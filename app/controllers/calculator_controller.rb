class CalculatorController < ApplicationController
  before_filter :load_vars

  def load_vars
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
  end

  def index
    redirect_to calculator_path(:locale => params[:set_locale], :calculator => params[:calculator]) if params[:set_locale]

    @calculator = Calculator.new(params[:calculator])

    if request.get?
      render :index
    else
      if @calculator.valid?
        respond_to do |format|
          format.html { redirect_to calculator_path(:calculator => params[:calculator]), :notice => 'Calculation was successfully completed.' }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to calculator_path(:calculator => params[:calculator]), :alert => "Calculation was not successfully completed. #{@calculator.errors.full_messages.to_sentence}" }
          format.js
        end
      end
    end
  end
end
  