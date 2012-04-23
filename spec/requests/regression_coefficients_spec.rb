require 'spec_helper'

describe "RegressionCoefficients" do
  
  before(:each) do
    @valid_regression_coefficient = RegressionCoefficient.make!
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_regression_coefficients_path
  end
  
  describe "- when admin attempts to create a regression_coefficient -" do
    before(:each) do
      click_link "New Regression coefficient"
    end
    it "invalid input is not accepted" do
      fill_in "Value", :with => "a"
      click_button "Create Regression coefficient"
      page.should have_content("Value is not a number")
    end
    it "a duplicate regression_coefficient is not accepted" do
      fill_in "Value", :with => @valid_regression_coefficient.value
      select @valid_regression_coefficient.crop.name, :from => "regression_coefficient_crop_id"
      select @valid_regression_coefficient.fertiliser.name, :from => "regression_coefficient_fertiliser_id"
      click_button "Create Regression coefficient"
      page.should have_content("Crop / Fertiliser coefficient already exists")
    end
    it "valid input is accepted" do
      new_valid_regression_coefficient = RegressionCoefficient.make
      new_valid_crop = Crop.make!
      new_valid_fertiliser = Fertiliser.make!
      visit new_admin_regression_coefficient_path
      fill_in "Value", :with => new_valid_regression_coefficient.value
      select new_valid_crop.name, :from => "regression_coefficient_crop_id"
      select new_valid_fertiliser.name, :from => "regression_coefficient_fertiliser_id"
      click_button "Create Regression coefficient"
      page.should have_content("Regression coefficient was successfully created.")
    end
  end
  
  describe "- when admin attempts to update a regression_coefficient -" do
    before(:each) do
      visit edit_admin_regression_coefficient_path(@valid_regression_coefficient)
    end
    it "empty input is not accepted" do
      fill_in "Value", :with => ""
      click_button "Update Regression coefficient"
      page.should have_content("Value can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Value", :with => "a"
      click_button "Update Regression coefficient"
      page.should have_content("Value is not a number")
    end
    it "unchanged input is accepted" do
      click_button "Update Regression coefficient"
      page.should have_content("Regression coefficient was successfully updated.")
    end
    it "valid input is accepted" do
      valid = RegressionCoefficient.make
      fill_in "Value", :with => valid.value
      click_button "Update Regression coefficient"
      page.should have_content("Regression coefficient was successfully updated.")
    end
  end
  
  describe "- when admin attempts to destroy a regression_coefficient -" do
    it "cannot destroy a regression_coefficient name that doesn't exist" do
      invalid_regression_coefficient = RegressionCoefficient.make
      get 'admin/regression_coefficients#destroy', :id => invalid_regression_coefficient.id
      response.should raise_error
    end
    it "can destroy a regression_coefficient that exists in the system" do
      pending("cannot seem to click on the okay confirmation box")
      page.driver.browser.switch_to.alert.accept
      click_link "Destroy"
      page.should_not have_content(@valid_regression_coefficient.name)
      page.should have_content("Regression coefficient was successfully destroyed.")
    end
  end
end
