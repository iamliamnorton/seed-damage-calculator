require 'spec_helper'

describe "SoilTextures", type: :feature do
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
      fill_in "Name", :with => "medium"
      click_button "Create Soil texture"
      page.should have_content("Soil texture was successfully created.")
    end

    it "a new soil_texture should produce corresponding soil_coefficients" do
      assert_equal(0, SoilCoefficient.count)
      soil_moisture = SoilMoisture.make!
      fill_in "Name", :with => "medium"
      click_button "Create Soil texture"
      page.should have_content("Soil texture was successfully created.")
      assert_equal(1, SoilCoefficient.count)
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
      valid = SoilTexture.make
      fill_in "Name", :with => valid.name
      click_button "Update Soil texture"
      page.should have_content("Soil texture was successfully updated.")
    end
  end

  describe "- when admin attempts to destroy a soil_texture -" do
    it "is removed from the database" do
      click_link "Destroy"
      page.should_not have_content(@valid_soil_texture.name)
      page.should have_content("Soil texture was successfully destroyed.")
    end

    it "destroys all corresponding soil_coefficients" do
      valid_soil_moisture = SoilMoisture.make!
      valid_soil_coeff = SoilCoefficient.make!(:soil_moisture => valid_soil_moisture, :soil_texture => @valid_soil_texture)
      assert_equal(1, SoilCoefficient.count)
      click_link "Destroy"
      assert_equal(0, SoilCoefficient.count)
    end
  end
end
