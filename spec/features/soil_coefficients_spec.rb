require 'spec_helper'

describe "SoilCoefficients", type: :feature do
  before(:each) do
    @valid_soil_coefficient = SoilCoefficient.make!
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_soil_coefficients_path
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
end
