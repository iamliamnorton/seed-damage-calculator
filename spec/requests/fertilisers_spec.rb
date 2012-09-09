require 'spec_helper'

describe "Fertilisers" do
  before(:each) do
    @valid_fertiliser = Fertiliser.make!
    page.driver.browser.authorize 'admin', 'admin'
    visit admin_fertilisers_path
  end

  describe "- when admin attempts to create a fertiliser -" do
    before(:each) do
      click_link "New Fertiliser"
    end

    it "empty input is not accepted" do
      click_button "Create Fertiliser"
      page.should have_content("Metric name can't be blank")
    end

    it "invalid input is not accepted" do
      fill_in "Metric name", :with => "A"
      fill_in "N", :with => "A"
      click_button "Create Fertiliser"
      page.should have_content("N is not a number")
    end

    it "a duplicate fertiliser is not accepted" do
      fill_in "Metric name", :with => @valid_fertiliser.metric_name
      click_button "Create Fertiliser"
      page.should have_content("Metric name has already been taken")
    end

    it "valid input is accepted" do
      new_valid_fertiliser = Fertiliser.make
      fill_in "Metric name", :with => new_valid_fertiliser.metric_name;
      fill_in "Imperial name", :with => new_valid_fertiliser.imperial_name
      click_button "Create Fertiliser"
      page.should have_content("Fertiliser was successfully created.")
    end

    it "a new fertiliser should produce corresponding regression_coefficients" do
      assert_equal(0, RegressionCoefficient.count)
      crop = Crop.make!
      new_fertiliser = Fertiliser.make
      fill_in "Metric name", :with => new_fertiliser.metric_name
      fill_in "Imperial name", :with => new_fertiliser.imperial_name
      click_button "Create Fertiliser"
      page.should have_content("Fertiliser was successfully created.")
      assert_equal(1, RegressionCoefficient.count)
    end
  end
  
  describe "- when admin attempts to update a fertiliser -" do
    before(:each) do
      visit edit_admin_fertiliser_path(@valid_fertiliser)
    end

    it "empty input is not accepted" do
      fill_in "Metric name", :with => ""
      click_button "Update Fertiliser"
      page.should have_content("Metric name can't be blank")
    end

    it "invalid input is not accepted" do
      fill_in "Metric name", :with => "N"
      fill_in "N", :with => "A"
      click_button "Update Fertiliser"
      page.should have_content("N is not a number")
    end

    it "unchanged input is accepted" do
      click_button "Update Fertiliser"
      page.should have_content("Fertiliser was successfully updated.")
    end

    it "valid input is accepted" do
      valid = Fertiliser.make
      fill_in "Metric name", :with => valid.metric_name
      fill_in "Imperial name", :with => valid.imperial_name
      click_button "Update Fertiliser"
      page.should have_content("Fertiliser was successfully updated.")
    end
  end
  
  describe "- when admin attempts to destroy a fertiliser -" do
    it "cannot destroy a fertiliser name that doesn't exist" do
      invalid_fertiliser = Fertiliser.make
      get 'admin/fertilisers#destroy', :id => invalid_fertiliser.id
      response.should raise_error
    end

    it "can destroy a fertiliser that exists in the system" do
      click_link "Destroy"
      page.should_not have_content(@valid_fertiliser.metric_name)
      page.should have_content("Fertiliser was successfully destroyed.")
    end

    it "destroys all corresponding regression_coefficients" do
      valid_crop = Crop.make!
      valid_regression_coeff = RegressionCoefficient.make!(:crop => valid_crop, :fertiliser => @valid_fertiliser)
      assert_equal(1, RegressionCoefficient.count)
      click_link "Destroy"
      assert_equal(0, RegressionCoefficient.count)
    end
  end
end
