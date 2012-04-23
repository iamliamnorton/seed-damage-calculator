class HomeController < ApplicationController
  def index
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
    @kg = ''
    @litres = ''
    @nitrogen = ''
    @phosphorus = ''
    @potassium = ''
    @sulphur = ''
    @magnesium = ''
    
    if request.post?
      #@result = 30S(-T)/CRMX
      regression_coefficient = RegressionCoefficient.where(:crop_id => params[:crop_id], :fertiliser_id => params[:fertiliser_id]).first.value
      soil_coefficient = SoilCoefficient.where(:soil_moisture_id => params[:soil_moisture_id], :soil_texture_id => params[:soil_texture_id]).first.value
      tmp1 = 30 * params[:seed_furrow_opening_width].to_i * -1 * params[:tol_stand_loss].to_i
      tmp2 = regression_coefficient * params[:row_spacing].to_i * soil_coefficient
      tmp3 = tmp1 / tmp2 
      @kg = tmp3

      if Fertiliser.find_by_id(params[:fertiliser_id]).kgL != 0 
        @litres = @kg / Fertiliser.find_by_id(params[:fertiliser_id]).kgL
      end
      
      @nitrogen = @kg * Fertiliser.find_by_id(params[:fertiliser_id]).N
      @phosphorus = @kg * Fertiliser.find_by_id(params[:fertiliser_id]).P
      @potassium = @kg * Fertiliser.find_by_id(params[:fertiliser_id]).K
      @sulphur = @kg * Fertiliser.find_by_id(params[:fertiliser_id]).S
      @magnesium = @kg * Fertiliser.find_by_id(params[:fertiliser_id]).Mg
      
    end
  end
end
