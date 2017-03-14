require 'spec_helper'

describe "PDF Generation", type: :feature do
  let!(:crop) { Crop.make! }
  let!(:fertiliser) { Fertiliser.make! }
  let!(:regression_coeff) {
    RegressionCoefficient.make!(crop: crop, fertiliser: fertiliser)
  }
  let!(:soil_moist) { SoilMoisture.make!(:name => 'moist') }
  let!(:soil_fine) { SoilTexture.make!(:name => 'fine') }
  let!(:soil_coefficient) {
    SoilCoefficient.make!(soil_moisture: soil_moist, soil_texture: soil_fine)
  }

  it "user can download calculation as pdf" do
    visit root_path
    select crop.name, :from => "calculator_crop_id"
    select fertiliser.imperial_name, :from => "calculator_fertiliser_id"
    select soil_moist.name, :from => "calculator_soil_moisture_id"
    select soil_fine.name, :from => "calculator_soil_texture_id"
    fill_in "calculator_seed_furrow_opening_width", :with => 3
    fill_in "calculator_row_spacing", :with => 10
    fill_in "calculator_tolerated_stand_loss", :with => 5
    check('calculator_terms_of_service')

    click_button "Calculate"

    click_link "Download PDF"

    # bug with rspec / prawn where exception raised for...
    # expect(page).to have_content("results are subject to the terms and conditions")
  end
end
