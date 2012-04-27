class CalculatorController < ApplicationController
  
  def index
    if params[:calculator]
      @calculator = Calculator.new(params[:calculator])
      @kg = @calculator.calculate_result
      @fertiliser = Fertiliser.find_by_id(@calculator.fertiliser_id)
      @litres = (@kg / @fertiliser.kgL).round(3) if @fertiliser.kgL > 0
      @nitrogen = @kg * @fertiliser.N
      @phosphorus = @kg * @fertiliser.P
      @potassium = @kg * @fertiliser.K
      @sulphur = @kg * @fertiliser.S
      @magnesium = @kg * @fertiliser.Mg    
    elsif 
      @calculator = Calculator.new
      @kg = ''
      @litres = ''
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
