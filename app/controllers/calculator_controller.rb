class CalculatorController < ApplicationController
  
  def index
    if params[:set_locale]
      @calculator = Calculator.new
      redirect_to calculator_path(:locale => params[:set_locale])
    else
      if params[:calculator]
        @calculator = Calculator.new(params[:calculator])
        @result = @calculator.calculate_result.round(1)
        @fertiliser = Fertiliser.find_by_id(@calculator.fertiliser_id)
        @liquid_weight = (@result / @fertiliser.liquid_weight).round(1)   if @fertiliser.liquid_weight.to_f > 0
        @nitrogen = (@result * @fertiliser.N).round(1)                    if @fertiliser.N.to_f > 0
        @phosphorus = (@result * @fertiliser.P).round(1)                  if @fertiliser.P.to_f > 0
        @potassium = (@result * @fertiliser.K).round(1)                   if @fertiliser.K.to_f > 0
        @sulphur = (@result * @fertiliser.S).round(1)                     if @fertiliser.S.to_f > 0
        @magnesium = (@result * @fertiliser.Mg).round(1)                  if @fertiliser.Mg.to_f > 0
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
          format.pdf do
            render :pdf => "calculator"
          end
        else
          errors = ''
          @calculator.errors.full_messages.each do |msg|
            errors = errors += msg + " "
          end
          format.html { redirect_to root_path(:calculator => params[:calculator]), alert: "Calculation was not successfully completed. #{errors}" }
        end
      end
    end
  end
end
