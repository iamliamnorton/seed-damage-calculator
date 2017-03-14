require 'spec_helper'

describe "Crops", type: :feature do
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
      expect(page).to have_content("Name can't be blank")
    end

    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Create Crop"
      expect(page).to have_content("Name can't be blank")
    end

    it "a duplicate crop is not accepted" do
      fill_in "Name", :with => @valid_crop.name
      click_button "Create Crop"
      expect(page).to have_content("Name has already been taken")
    end

    it "valid input is accepted" do
      new_valid_crop = Crop.make
      fill_in "Name", :with => new_valid_crop.name
      click_button "Create Crop"
      expect(page).to have_content("Crop was successfully created.")
    end

    it "a new crop should produce corresponding regression_coefficients" do
      assert_equal(0, RegressionCoefficient.count)
      fertiliser = Fertiliser.make!
      new_crop = Crop.make
      fill_in "Name", :with => new_crop.name
      click_button "Create Crop"
      expect(page).to have_content("Crop was successfully created.")
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
      expect(page).to have_content("Name can't be blank")
    end

    it "invalid input is not accepted" do
      fill_in "Name", :with => " "
      click_button "Update Crop"
      expect(page).to have_content("Name can't be blank")
    end

    it "unchanged input is accepted" do
      click_button "Update Crop"
      expect(page).to have_content("Crop was successfully updated.")
    end

    it "valid input is accepted" do
      valid = Crop.make
      fill_in "Name", :with => valid.name
      click_button "Update Crop"
      expect(page).to have_content("Crop was successfully updated.")
    end
  end

  describe "- when admin attempts to destroy a crop -" do
    it "is removed from the database" do
      click_link "Destroy"
      expect(page).to_not have_content(@valid_crop.name)
      expect(page).to have_content("Crop was successfully destroyed.")
    end

    it "destroys all corresponding regression_coefficients" do
      valid_fertiliser = Fertiliser.make!
      valid_regression_coeff = RegressionCoefficient.make!(:crop => @valid_crop, :fertiliser => valid_fertiliser)
      assert_equal(1, RegressionCoefficient.count)
      click_link "Destroy"
      assert_equal(0, RegressionCoefficient.count)
    end
  end
end
