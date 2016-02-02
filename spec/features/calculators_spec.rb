require 'spec_helper'

describe "Calculation", type: :feature do
  let!(:crop_1) { Crop.make! }
  let!(:crop_2) { Crop.make! }
  let!(:fertiliser_1) { Fertiliser.make! }
  let!(:fertiliser_2) { Fertiliser.make! }
  let!(:regression_1_1) { RegressionCoefficient.make!(:crop => crop_1, :fertiliser => fertiliser_1) }
  let!(:regression_1_2) { RegressionCoefficient.make!(:crop => crop_1, :fertiliser => fertiliser_2) }
  let!(:regression_2_1) { RegressionCoefficient.make!(:crop => crop_2, :fertiliser => fertiliser_1) }
  let!(:regression_2_2) { RegressionCoefficient.make!(:crop => crop_2, :fertiliser => fertiliser_2) }
  let!(:soil_moist) { SoilMoisture.make!(:name => 'moist') }
  let!(:soil_dry) { SoilMoisture.make!(:name => 'dry') }
  let!(:soil_fine) { SoilTexture.make!(:name => 'fine') }
  let!(:soil_coarse) { SoilTexture.make!(:name => 'coarse') }
  let!(:soil_coefficient_1) { SoilCoefficient.make!(:soil_moisture => soil_moist, :soil_texture => soil_fine) }
  let!(:soil_coefficient_2) { SoilCoefficient.make!(:soil_moisture => soil_moist, :soil_texture => soil_coarse) }
  let!(:soil_coefficient_3) { SoilCoefficient.make!(:soil_moisture => soil_dry, :soil_texture => soil_fine) }
  let!(:soil_coefficient_4) { SoilCoefficient.make!(:soil_moisture => soil_dry, :soil_texture => soil_coarse) }

  describe "performing a calculation", js: true do
    before(:each) do
      visit root_path
      select crop_1.name, :from => "calculator_crop_id"
      select fertiliser_1.metric_name, :from => "calculator_fertiliser_id"
      select soil_moist.name, :from => "calculator_soil_moisture_id"
      select soil_fine.name, :from => "calculator_soil_texture_id"
      fill_in "calculator_seed_furrow_opening_width", :with => 3
      fill_in "calculator_row_spacing", :with => 10
      fill_in "calculator_tolerated_stand_loss", :with => 5
      check('calculator_terms_of_service')
    end

    context "when valid input is selected" do
      before(:each) do
        click_button "Calculate"
      end

      it "success notification is shown" do
        page.should have_content("Calculation successful.")
      end

      it "should print some results" do
        page.should have_content("Maximium kg/ha of fertiliser product with seed")
        find(:css, 'input#result').value.should_not be_nil
        find(:css, 'input#result').value.should_not == ""
      end

      context "when changing locales" do
        it "should return results in that locale" do
          select "Imperial", from: "set_locale"

          page.should have_content("Fertilizer")
          page.should_not have_content("Fertiliser")

          select crop_1.name, :from => "calculator_crop_id"
          select fertiliser_1.imperial_name, :from => "calculator_fertiliser_id"
          select soil_moist.name, :from => "calculator_soil_moisture_id"
          select soil_fine.name, :from => "calculator_soil_texture_id"
          fill_in "calculator_seed_furrow_opening_width", :with => 3
          fill_in "calculator_row_spacing", :with => 10
          fill_in "calculator_tolerated_stand_loss", :with => 5
          check('calculator_terms_of_service')

          click_button "Calculate"
          page.should have_content("Maximium lbs/ac of fertilizer product with seed")
        end
      end
    end

    context "when invalid input is selected" do
      describe "for range of integers" do
        before(:each) do
          fill_in "calculator_seed_furrow_opening_width", :with => -3
          click_button "Calculate"
        end

        it "should alert the user" do
          page.should have_content("Calculation unsuccessful.")
        end

        it "should not print results" do
          find(:css, 'input#result').value.should == ""
        end
      end

      describe "for terms of service non-acceptance" do
        before(:each) do
          uncheck('calculator_terms_of_service')
          click_button "Calculate"
        end

        it "should alert the user" do
          page.should have_content("Please fill in all fields appropriately")
        end

        it "should not print results" do
          find(:css, 'input#result').value.should == ""
        end
      end
    end

    describe "can change locales within the app" do
      it "defaults to metric if no locale is set" do
        visit calculator_path
        page.should have_content("This calculator can be used as a guide to the maximum amount of fertiliser that can be applied in the same furrow as seed.")
      end
      it "can choose the metric locale" do
        visit calculator_path
        select "Metric", :from => "set_locale"
        page.should have_content("This calculator can be used as a guide to the maximum amount of fertiliser that can be applied in the same furrow as seed.")
      end

      it "can choose the imperial locale" do
        visit calculator_path
        select "Imperial", :from => "set_locale"
        page.should have_content("This calculator can be used as a guide to the maximum amount of fertilizer that can be applied in the same furrow as seed.")
      end
    end

    describe "can change locales within the app" do
      it "can choose the metric locale" do
        select "Metric", :from => "set_locale"
        page.should have_content("Fertiliser")
        page.should_not have_content("Fertilizer")
      end

      it "can choose the imperial locale" do
        select "Imperial", :from => "set_locale"
        page.should have_content("Fertilizer")
        page.should_not have_content("Fertiliser")
      end
    end
  end
end