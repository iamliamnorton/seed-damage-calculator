class CalculatorController < ApplicationController

  def index

    redirect_to calculator_path(:locale => params[:set_locale], :calculator => params[:calculator]) if params[:set_locale]

    @calculator = Calculator.new
    @calculator = Calculator.new(params[:calculator]) if params[:calculator]
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all

    if request.post? && params[:calculator]
      respond_to do |format|
        if @calculator.valid?
          format.html { redirect_to root_path(:locale => params[:set_locale], :calculator => params[:calculator]), notice: 'Calculation was successfully completed.' }
        else
          # This will have to be redone, need a better way of showing errors in the calculator form
          errors = ''
          @calculator.errors.full_messages.each do |msg|
            errors += msg + "\n"
          end
          format.html { redirect_to calculator_path(:calculator => params[:calculator]), alert: "Calculation was not successfully completed. #{errors}" }
        end
      end
    end
  end
end
  