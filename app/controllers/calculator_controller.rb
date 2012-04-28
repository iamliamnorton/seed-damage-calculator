class CalculatorController < ApplicationController
  
  def index
    if params[:set_locale]
      @calculator = Calculator.new
      redirect_to calculator_path(:locale => params[:set_locale])
    else
      if params[:calculator]
        @calculator = Calculator.new(params[:calculator])
        @result = @calculator.calculate_result
        @fertiliser = Fertiliser.find_by_id(@calculator.fertiliser_id)
        @liquid_weight = (@result / @fertiliser.liquid_weight).round(3) if @fertiliser.liquid_weight > 0
        @nitrogen = @result * @fertiliser.N
        @phosphorus = @result * @fertiliser.P
        @potassium = @result * @fertiliser.K
        @sulphur = @result * @fertiliser.S
        @magnesium = @result * @fertiliser.Mg    
      elsif 
        @calculator = Calculator.new
        @result = ''
        @liquid_weight = ''
        @nitrogen = ''
        @phosphorus = ''
        @potassium = ''
        @sulphur = ''
        @magnesium = ''
      end
      @crops = Crop.all
      @fertilisers = Fertiliser.all
      @soil_moistures = SoilMoisture.all
      @soil_textures = SoilTexture.all
    end
    
    if request.post? && params[:calculator]
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
