require 'spec_helper'

describe "Calculators" do
  
  before(:each) do
    I18n.locale = :imperial
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
      select @fertiliser_1.imperial_name, :from => "calculator_fertiliser_id"
      select @soil_moist.name, :from => "calculator_soil_moisture_id"
      select @soil_fine.name, :from => "calculator_soil_texture_id"
      fill_in "calculator_seed_furrow_opening_width", :with => 3
      fill_in "calculator_row_spacing", :with => 10
      fill_in "calculator_tolerated_stand_loss", :with => 5
      check('calculator_terms_of_service')
    end
    it "results are printed to the screen" do
      click_button "Calculate"
      page.should have_content("Calculation was successfully completed.")
    end
  end
  
  describe "when invalid input exists" do
    before(:each) do
      select @crop_1.name, :from => "calculator_crop_id"
      select @fertiliser_1.imperial_name, :from => "calculator_fertiliser_id"
      select @soil_moist.name, :from => "calculator_soil_moisture_id"
      select @soil_fine.name, :from => "calculator_soil_texture_id"
      fill_in "calculator_seed_furrow_opening_width", :with => 3
      fill_in "calculator_row_spacing", :with => 1000
      fill_in "calculator_tolerated_stand_loss", :with => 5
      check('calculator_terms_of_service')
    end
    it "results are printed to the screen" do
      click_button "Calculate"
      page.should have_content("Calculation was not successfully completed.")
    end
  end
  
  describe "when invalid input exists" do
    before(:each) do
      select @crop_1.name, :from => "calculator_crop_id"
      select @fertiliser_1.imperial_name, :from => "calculator_fertiliser_id"
      select @soil_moist.name, :from => "calculator_soil_moisture_id"
      select @soil_fine.name, :from => "calculator_soil_texture_id"
      fill_in "calculator_seed_furrow_opening_width", :with => 3
      fill_in "calculator_row_spacing", :with => 50
      fill_in "calculator_tolerated_stand_loss", :with => 5
    end
    it "results are printed to the screen" do
      click_button "Calculate"
      page.should have_content("Terms of service is not accepted")
    end
  end
  
  describe "can change locales within the app" do
    it "can choose the metric locale" do
      I18n.locale = :metric
      visit calculator_path
      page.should have_content("This calculator can be used as a guide to the maximum amount of fertiliser that can be applied in the same furrow as seed.")
    end
    
    it "can choose the imperial locale" do
      I18n.locale = :imperial
      visit calculator_path
      page.should have_content("This calculator can be used as a guide to the maximum amount of fertilizer that can be applied in the same furrow as seed.")
    end
    
    it "defaults to metric if no locale is set" do
      I18n.locale = nil
      visit calculator_path
      page.should have_content("This calculator can be used as a guide to the maximum amount of fertiliser that can be applied in the same furrow as seed.")
    end
  end
  
  # describe "the locale selecter", :js => true do
  #   it "is defaulted to metric" do
  #     # select "Metric", :from => "set_locale"  
  #     page.should have_content("Fertiliser")
  #     page.should_not have_content("Fertilizer")
  #   end
  #   it "can be changed to imperial" do
  #     select "Imperial", :from => "set_locale"
  #     page.should have_content("Fertilizer")
  #     page.should_not have_content("Fertiliser")
  #   end
  # end
end
