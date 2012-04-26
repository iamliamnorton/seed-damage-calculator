class CalculatorController < ApplicationController
  
  def index
    if params[:calculator]
      @calculator = Calculator.new(params[:calculator])
    elsif 
      @calculator = Calculator.new
    end
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
    
    if params[:calculator] && @calculator.valid?
      regression_coefficient = RegressionCoefficient.where(:crop_id => @calculator.crop_id, :fertiliser_id => @calculator.fertiliser_id).first.value
      soil_coefficient = SoilCoefficient.where(:soil_moisture_id => @calculator.soil_moisture_id, :soil_texture_id => @calculator.soil_texture_id).first.value
      tmp1 = 30 * @calculator.seed_furrow_opening_width.to_i * -1 * @calculator.tolerated_stand_loss.to_i
      tmp2 = regression_coefficient * @calculator.row_spacing.to_i * soil_coefficient
      @kg = tmp1 / tmp2
      
      @fertiliser = Fertiliser.find_by_id(@calculator.fertiliser_id)

      if @fertiliser
        @litres = @kg / @fertiliser.kgL if @fertiliser.kgL > 0
        @nitrogen = @kg * @fertiliser.N
        @phosphorus = @kg * @fertiliser.P
        @potassium = @kg * @fertiliser.K
        @sulphur = @kg * @fertiliser.S
        @magnesium = @kg * @fertiliser.Mg        
      end
    end
    
    if request.post?
      respond_to do |format|
        if @calculator.valid?
          format.html { redirect_to root_path(:calculator => params[:calculator]), notice: 'Calculation was successfully completed.' }
        else
          format.html { redirect_to root_path(:calculator => params[:calculator]), alert: 'Calculation was not successfully completed.' }
        end
      end
    end
  end
end
