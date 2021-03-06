require 'spec_helper'

describe "RegressionCoefficients", type: :feature do
  before(:each) do
    @valid_regression_coefficient = create(:regression_coefficient)
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_regression_coefficients_path
  end

  describe "- when admin attempts to update a regression_coefficient -" do
    before(:each) do
      visit edit_admin_regression_coefficient_path(@valid_regression_coefficient)
    end

    it "empty input is not accepted" do
      fill_in "Value", :with => ""
      click_button "Update Regression coefficient"
      expect(page).to have_content("Value can't be blank")
    end

    it "invalid input is not accepted" do
      fill_in "Value", :with => "a"
      click_button "Update Regression coefficient"
      expect(page).to have_content("Value is not a number")
    end

    it "unchanged input is accepted" do
      click_button "Update Regression coefficient"
      expect(page).to have_content("Regression coefficient was successfully updated.")
    end

    it "valid input is accepted" do
      valid = build(:regression_coefficient)
      fill_in "Value", :with => valid.value
      click_button "Update Regression coefficient"
      expect(page).to have_content("Regression coefficient was successfully updated.")
    end
  end
end
