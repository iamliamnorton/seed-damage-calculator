require 'spec_helper'

describe "SoilMoistures" do
  
  before(:each) do
    @valid_soil_moisture = SoilMoisture.make!
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_soil_moistures_path
  end
  
  describe "- when admin attempts to create a soil_moisture -" do
    before(:each) do
      click_link "New Soil moisture"
    end
    it "empty input is not accepted" do
      click_button "Create Soil moisture"
      page.should have_content("Name can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Create Soil moisture"
      page.should have_content("Name can't be blank")
    end
    it "a duplicate soil_moisture is not accepted" do
      fill_in "Name", :with => @valid_soil_moisture.name
      click_button "Create Soil moisture"
      page.should have_content("Name has already been taken")
    end
    it "valid input is accepted" do
      new_valid_soil_moisture = SoilMoisture.make
      fill_in "Name", :with => new_valid_soil_moisture.name
      click_button "Create Soil moisture"
      page.should have_content("Soil moisture was successfully created.")
    end
    it "a new soil_moisture should produce corresponding soil_coefficients" do      
      assert_equal(0, SoilCoefficient.count)
      soil_texture = SoilTexture.make!
      new_soil_moisture = SoilMoisture.make
      fill_in "Name", :with => new_soil_moisture.name
      click_button "Create Soil moisture"
      page.should have_content("Soil moisture was successfully created.")
      assert_equal(1, SoilCoefficient.count)
    end
  end
  
  describe "- when admin attempts to update a soil_moisture -" do
    before(:each) do
      visit edit_admin_soil_moisture_path(@valid_soil_moisture)
    end
    it "empty input is not accepted" do
      fill_in "Name", :with => ""
      click_button "Update Soil moisture"
      page.should have_content("Name can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Update Soil moisture"
      page.should have_content("Name can't be blank")
    end
    it "unchanged input is accepted" do
      click_button "Update Soil moisture"
      page.should have_content("Soil moisture was successfully updated.")
    end
    it "valid input is accepted" do
      valid = SoilMoisture.make
      fill_in "Name", :with => valid.name
      click_button "Update Soil moisture"
      page.should have_content("Soil moisture was successfully updated.")
    end
  end
  
  describe "- when admin attempts to destroy a soil_moisture -" do
    before(:each) do
      page.driver.browser.basic_authorize('admin', 'admin')
      visit admin_soil_moistures_path
    end
    it "cannot destroy a soil_moisture name that doesn't exist" do
      invalid_soil_moisture = SoilMoisture.make
      get 'admin/soil_moistures#destroy', :id => invalid_soil_moisture.id
      response.should raise_error
    end
    it "can destroy a soil_moisture that exists in the system" do
      click_link "Destroy"
      page.should_not have_content(@valid_soil_moisture.name)
      page.should have_content("Soil moisture was successfully destroyed.")
    end
    it "destroys all corresponding soil_coefficients" do
      valid_soil_texture = SoilTexture.make!
      valid_soil_coeff = SoilCoefficient.make!(:soil_moisture => @valid_soil_moisture, :soil_texture => valid_soil_texture)
      assert_equal(1, SoilCoefficient.count)
      click_link "Destroy"
      assert_equal(0, SoilCoefficient.count)
    end
  end

end
