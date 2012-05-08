class CalculatorController < ApplicationController
  
  def index
    if params[:set_locale]
      redirect_to calculator_path(:locale => params[:set_locale], :calculator => params[:calculator])
    end
    if params[:calculator]
      @calculator = Calculator.new(params[:calculator])
      @result = @calculator.calculate_result
      @sbu = @calculator.calculate_sbu
      @liquid_weight = @calculator.calculate_liquid_weight(@result)
      @nitrogen = @calculator.calculate_nitrogen(@result)
      @phosphorus = @calculator.calculate_phosphorus(@result)
      @potassium = @calculator.calculate_potassium(@result)
      @sulphur = @calculator.calculate_sulphur(@result)
      @magnesium = @calculator.calculate_magnesium(@result)
      @result = @result.round(1) if !@result.nil?    #rounded here so precision of other results is not affected
    else
      @calculator = Calculator.new
    end
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
    
    if request.post? && params[:calculator]
      respond_to do |format|
        if @calculator.valid?
          format.html { redirect_to root_path(:calculator => params[:calculator]), notice: 'Calculation was successfully completed.' }
        else
          # This will have to be redone, need a better way of showing errors in the calculator form
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
  