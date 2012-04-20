require 'spec_helper'

describe "SoilTextures" do
  
  before(:each) do
    @valid_soil_texture = SoilTexture.make!
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_soil_textures_path
  end
  
  describe "- when admin attempts to create a soil_texture -" do
    before(:each) do
      click_link "New Soil texture"
    end
    it "empty input is not accepted" do
      click_button "Create Soil texture"
      page.should have_content("Name can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Create Soil texture"
      page.should have_content("Name can't be blank")
    end
    it "a duplicate soil_texture is not accepted" do
      fill_in "Name", :with => @valid_soil_texture.name
      click_button "Create Soil texture"
      page.should have_content("Name has already been taken")
    end
    it "valid input is accepted" do
      new_valid_soil_texture = SoilTexture.make
      fill_in "Name", :with => new_valid_soil_texture.name
      click_button "Create Soil texture"
      page.should have_content("Soil texture was successfully created.")
    end
  end
  
  describe "- when admin attempts to update a soil_texture -" do
    before(:each) do
      visit edit_admin_soil_texture_path(@valid_soil_texture)
    end
    it "empty input is not accepted" do
      fill_in "Name", :with => ""
      click_button "Update Soil texture"
      page.should have_content("Name can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Update Soil texture"
      page.should have_content("Name can't be blank")
    end
    it "unchanged input is accepted" do
      click_button "Update Soil texture"
      page.should have_content("Soil texture was successfully updated.")
    end
    it "valid input is accepted" do
      valid = Fertiliser.make
      fill_in "Name", :with => valid.name
      click_button "Update Soil texture"
      page.should have_content("Soil texture was successfully updated.")
    end
  end
  
  describe "- when admin attempts to destroy a soil_texture -" do
    it "cannot destroy a soil_texture name that doesn't exist" do
      invalid_soil_texture = SoilTexture.make
      get 'admin/soil_textures#destroy', :id => invalid_soil_texture.id
      response.should raise_error
    end
    it "can destroy a soil_texture that exists in the system" do
      pending("cannot seem to click on the okay confirmation box")
      page.driver.browser.switch_to.alert.accept
      click_link "Destroy"
      page.should_not have_content(@valid_soil_texture.name)
      page.should have_content("Soil texture was successfully destroyed.")
    end
  end
end
