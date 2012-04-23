require 'spec_helper'

describe "SoilCoefficients" do
  
  before(:each) do
    @valid_soil_coefficient = SoilCoefficient.make!
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_soil_coefficients_path
  end
  
  describe "- when admin attempts to create a soil_coefficient -" do
    before(:each) do
      click_link "New Soil coefficient"
    end
    it "invalid input is not accepted" do
      fill_in "Value", :with => "a"
      click_button "Create Soil coefficient"
      page.should have_content("Value is not a number")
    end
    it "a duplicate soil_coefficient is not accepted" do
      fill_in "Value", :with => @valid_soil_coefficient.value
      select @valid_soil_coefficient.soil_texture.name, :from => "soil_coefficient_soil_texture_id"
      select @valid_soil_coefficient.soil_moisture.name, :from => "soil_coefficient_soil_moisture_id"
      click_button "Create Soil coefficient"
      page.should have_content("Soil moisture / texture coefficient already exists")
    end
    it "valid input is accepted" do
      new_valid_soil_coefficient = SoilCoefficient.make
      new_valid_soil_moisture = SoilMoisture.make!
      new_valid_soil_texture = SoilTexture.make!
      visit new_admin_soil_coefficient_path
      fill_in "Value", :with => new_valid_soil_coefficient.value
      select new_valid_soil_texture.name, :from => "soil_coefficient_soil_texture_id"
      select new_valid_soil_moisture.name, :from => "soil_coefficient_soil_moisture_id"
      click_button "Create Soil coefficient"
      page.should have_content("Soil coefficient was successfully created.")
    end
  end
  
  describe "- when admin attempts to update a soil_coefficient -" do
    before(:each) do
      visit edit_admin_soil_coefficient_path(@valid_soil_coefficient)
    end
    it "empty input is not accepted" do
      fill_in "Value", :with => ""
      click_button "Update Soil coefficient"
      page.should have_content("Value can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Value", :with => "a"
      click_button "Update Soil coefficient"
      page.should have_content("Value is not a number")
    end
    it "unchanged input is accepted" do
      click_button "Update Soil coefficient"
      page.should have_content("Soil coefficient was successfully updated.")
    end
    it "valid input is accepted" do
      valid = SoilCoefficient.make
      fill_in "Value", :with => valid.value
      click_button "Update Soil coefficient"
      page.should have_content("Soil coefficient was successfully updated.")
    end
  end
  
  describe "- when admin attempts to destroy a soil_coefficient -" do
    it "cannot destroy a soil_coefficient name that doesn't exist" do
      invalid_soil_coefficient = SoilCoefficient.make
      get 'admin/soil_coefficients#destroy', :id => invalid_soil_coefficient.id
      response.should raise_error
    end
    it "can destroy a soil_coefficient that exists in the system" do
      pending("cannot seem to click on the okay confirmation box")
      page.driver.browser.switch_to.alert.accept
      click_link "Destroy"
      page.should_not have_content(@valid_soil_coefficient.name)
      page.should have_content("Soil coefficient was successfully destroyed.")
    end
  end
end
