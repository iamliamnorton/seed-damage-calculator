require 'spec_helper'

describe "Calculation", type: :feature do
  let!(:crop_1) { create(:crop) }
  let!(:crop_2) { create(:crop) }
  let!(:fertiliser_1) { create(:fertiliser) }
  let!(:fertiliser_2) { create(:fertiliser) }
  let!(:regression_1_1) { create(:regression_coefficient, crop: crop_1, fertiliser: fertiliser_1) }
  let!(:regression_1_2) { create(:regression_coefficient, crop: crop_1, fertiliser: fertiliser_2) }
  let!(:regression_2_1) { create(:regression_coefficient, crop: crop_2, fertiliser: fertiliser_1) }
  let!(:regression_2_2) { create(:regression_coefficient, crop: crop_2, fertiliser: fertiliser_2) }
  let!(:soil_moist) { create(:soil_moisture, name: 'moist') }
  let!(:soil_dry) { create(:soil_moisture, name: 'dry') }
  let!(:soil_fine) { create(:soil_texture, name: 'fine') }
  let!(:soil_coarse) { create(:soil_texture, name: 'coarse') }
  let!(:soil_coefficient_1) { create(:soil_coefficient, soil_moisture: soil_moist, soil_texture: soil_fine) }
  let!(:soil_coefficient_2) { create(:soil_coefficient, soil_moisture: soil_moist, soil_texture: soil_coarse) }
  let!(:soil_coefficient_3) { create(:soil_coefficient, soil_moisture: soil_dry, soil_texture: soil_fine) }
  let!(:soil_coefficient_4) { create(:soil_coefficient, soil_moisture: soil_dry, soil_texture: soil_coarse) }

  describe "performing a calculation", js: true do
    before(:each) do
      visit root_path
      select crop_1.name, :from => "calculator_crop_id"
      select fertiliser_1.imperial_name, :from => "calculator_fertiliser_id"
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
        expect(page).to have_content("Calculation successful.")
      end

      it "should print some results" do
        expect(page).to have_content("Maximium lbs/ac of fertilizer product with seed")
        expect(page).to have_content("Fertilizer")
        expect(page).to_not have_content("Fertiliser")
        expect(find(:css, 'input#result').value).not_to be_nil
        expect(find(:css, 'input#result').value).not_to eq("")
      end

      context "when changing locales" do
        it "should return results in that locale" do
          select "Metric", from: "locale"

          expect(page).to_not have_content("Fertilizer")
          expect(page).to have_content("Fertiliser")

          select crop_1.name, :from => "calculator_crop_id"
          select fertiliser_1.metric_name, :from => "calculator_fertiliser_id"
          select soil_moist.name, :from => "calculator_soil_moisture_id"
          select soil_fine.name, :from => "calculator_soil_texture_id"
          fill_in "calculator_seed_furrow_opening_width", :with => 3
          fill_in "calculator_row_spacing", :with => 10
          fill_in "calculator_tolerated_stand_loss", :with => 5
          check('calculator_terms_of_service')

          click_button "Calculate"
          expect(page).to have_content("Maximium kg/ha of fertiliser product with seed")
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
          expect(page).to have_content("Calculation unsuccessful.")
        end

        it "should not print results" do
          expect(find(:css, 'input#result').value).to eq("")
        end
      end

      describe "for terms of service non-acceptance" do
        before(:each) do
          uncheck('calculator_terms_of_service')
          click_button "Calculate"
        end

        it "should alert the user" do
          expect(page).to have_content("Please fill in all fields appropriately")
        end

        it "should not print results" do
          expect(find(:css, 'input#result').value).to eq("")
        end
      end
    end

    describe "can change locales within the app" do
      it "can choose the metric locale" do
        select "Metric", :from => "locale"
        expect(page).to have_content("Fertiliser")
        expect(page).to_not have_content("Fertilizer")
      end

      it "can choose the imperial locale" do
        select "Imperial", :from => "locale"
        expect(page).to have_content("Fertilizer")
        expect(page).to_not have_content("Fertiliser")
      end
    end
  end
end
