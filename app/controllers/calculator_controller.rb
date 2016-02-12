class CalculatorController < ApplicationController
  before_filter :load_variables

  def index
    I18n.locale = params[:calculator] && params[:calculator][:locale] || "imperial"

    @calculator = Calculator.new(params[:calculator])

    if request.post?
      if @calculator.valid?
        flash[:notice] = "Calculation successful."
      else
        flash[:alert] = "Calculation unsuccessful. Please fill in all fields appropriately."
      end
      redirect_to calculator_path({
        calculator: calculator_params
      })
    end
  end

  def calculator_params
    (params[:calculator] || {}).merge(locale: I18n.locale)
  end

  private

  def load_variables
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
  end
end
