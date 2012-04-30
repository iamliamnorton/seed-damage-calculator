require 'spec_helper'

describe "Calculators" do
  
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
  
  describe "when valid input exists" do
    before(:each) do
      select @crop_1.name, :from => "calculator_crop_id"
      select @fertiliser_1.name, :from => "calculator_fertiliser_id"
      select @soil_moist.name, :from => "calculator_soil_moisture_id"
      select @soil_fine.name, :from => "calculator_soil_texture_id"
      fill_in "calculator_seed_furrow_opening_width", :with => 3
      fill_in "calculator_row_spacing", :with => 10
      fill_in "calculator_tolerated_stand_loss", :with => 5
    end
    it "results are printed to the screen" do
      click_button "Calculate"
      page.should have_content("Calculation was successfully completed.")
    end
    it "results can be printed to PDF" do
      pending("need to get this functionality created first")
    end
  end
  
  describe "when invalid input exists" do
    before(:each) do
      select @crop_1.name, :from => "calculator_crop_id"
      select @fertiliser_1.name, :from => "calculator_fertiliser_id"
      select @soil_moist.name, :from => "calculator_soil_moisture_id"
      select @soil_fine.name, :from => "calculator_soil_texture_id"
      fill_in "calculator_seed_furrow_opening_width", :with => 3
      fill_in "calculator_row_spacing", :with => 1000
      fill_in "calculator_tolerated_stand_loss", :with => 5
    end
    it "results are printed to the screen" do
      click_button "Calculate"
      page.should have_content("Calculation was not successfully completed.")
    end
    it "results CANNOT be printed to PDF" do
      pending("need to get this functionality created first")
    end
  end
  
  describe "the locale selecter", :js => true do
    it "is defaulted to metric" do
      page.should have_content("Fertiliser And Seed Decision Aid Calculator")
    end
    it "can be changed to imperial" do
      select "Imperial", :from => "set_locale"
      page.should have_content("Fertilizer And Seed Decision Aid Calculator")
    end
  end
end
