require 'spec_helper'

describe "Workflow" do
  
  before(:each) do
    @crop_1 = Crop.make!
    @crop_2 = Crop.make!
    @fertiliser_1 = Fertiliser.make!
    @fertiliser_2 = Fertiliser.make!
    @regression_1_1 = RegressionCoefficient.make!(:crop => @crop_1, :fertiliser => @fertiliser_1)
    @regression_1_2 = RegressionCoefficient.make!(:crop => @crop_1, :fertiliser => @fertiliser_2)
    @regression_2_1 = RegressionCoefficient.make!(:crop => @crop_2, :fertiliser => @fertiliser_1)
    @regression_2_2 = RegressionCoefficient.make!(:crop => @crop_2, :fertiliser => @fertiliser_2)
    @soil_moist = SoilMoisture.make!(:name => 'moist')
    @soil_dry = SoilMoisture.make!(:name => 'dry')
    @soil_fine = SoilTexture.make!(:name => 'fine')
    @soil_coarse = SoilTexture.make!(:name => 'coarse')
    @soil_coefficient_1 = SoilCoefficient.make!(:soil_moisture => @soil_moist, :soil_texture => @soil_fine)
    @soil_coefficient_2 = SoilCoefficient.make!(:soil_moisture => @soil_moist, :soil_texture => @soil_coarse)
    @soil_coefficient_3 = SoilCoefficient.make!(:soil_moisture => @soil_dry, :soil_texture => @soil_fine)
    @soil_coefficient_4 = SoilCoefficient.make!(:soil_moisture => @soil_dry, :soil_texture => @soil_coarse)
    visit root_path
  end
  
  describe "when a user visits site and uses the calculator" do
    
    it "when incorrect variables are used in the text_area_inputs" do
      click_button "Calculate"
      page.should have_content("Incorrect variables used")
    end
    
    it "when proper variables used" do
      select @crop_1.name, :from => "crop_id"
      select @fertiliser_1.name, :from => "fertiliser_id"
      select @soil_moist.name, :from => "soil_moisture_id"
      select @soil_fine.name, :from => "soil_texture_id"
      fill_in "seed_furrow_opening_width", :with => 3
      fill_in "row_spacing", :with => 10
      fill_in "tol_stand_loss", :with => 10
      click_button "Calculate"
      page.should have_content("Calculation complete.")
    end
    
  end
  
end