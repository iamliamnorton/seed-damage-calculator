require 'spec_helper'

describe "Crops" do
  
  before(:each) do
    @valid_crop = Crop.make!
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_crops_path
  end
  
  describe "- when admin attempts to create a crop -" do
    before(:each) do
      click_link "New Crop"
    end
    it "empty input is not accepted" do
      click_button "Create Crop"
      page.should have_content("Name can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Create Crop"
      page.should have_content("Name can't be blank")
    end
    it "a duplicate crop is not accepted" do
      fill_in "Name", :with => @valid_crop.name
      click_button "Create Crop"
      page.should have_content("Name has already been taken")
    end
    it "valid input is accepted" do
      new_valid_crop = Crop.make
      fill_in "Name", :with => new_valid_crop.name
      click_button "Create Crop"
      page.should have_content("Crop was successfully created.")
    end
    it "a new crop should produce corresponding regression_coefficients" do
      assert_equal(0, RegressionCoefficient.count)
      fertiliser = Fertiliser.make!
      new_crop = Crop.make
      fill_in "Name", :with => new_crop.name
      click_button "Create Crop"
      page.should have_content("Crop was successfully created.")
      assert_equal(1, RegressionCoefficient.count)
    end
  end
  
  describe "- when admin attempts to update a crop -" do
    before(:each) do
      visit edit_admin_crop_path(@valid_crop)
    end
    it "empty input is not accepted" do
      fill_in "Name", :with => ""
      click_button "Update Crop"
      page.should have_content("Name can't be blank")
    end
    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Update Crop"
      page.should have_content("Name can't be blank")
    end
    it "unchanged input is accepted" do
      click_button "Update Crop"
      page.should have_content("Crop was successfully updated.")
    end
    it "valid input is accepted" do
      valid = Crop.make
      fill_in "Name", :with => valid.name
      click_button "Update Crop"
      page.should have_content("Crop was successfully updated.")
    end
  end
  
  describe "- when admin attempts to destroy a crop -" do
    it "cannot destroy a crop name that doesn't exist" do
      invalid_crop = Crop.make
      response.should raise_error
    end
    it "can destroy a crop that exists in the system" do
      pending("cannot seem to click on the okay confirmation box")
      click_link "Destroy"
      page.should_not have_content(@valid_crop.name)
      page.should have_content("Crop was successfully destroyed.")
    end
    it "destroys all corresponding regression_coefficients" do
      pending("cannot seem to click on the okay confirmation box")
    end
  end
end
