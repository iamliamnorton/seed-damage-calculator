class CalculatorController < ApplicationController
  before_filter :load_variables
  before_filter :set_locale

  def index
    @calculator = Calculator.new(calculator_params)

    if request.post?
      if @calculator.valid?
        flash[:notice] = "Calculation successful."
      else
        flash[:alert] = "Calculation unsuccessful. Please fill in all fields appropriately."
      end
      redirect_to calculator_path(calculator: calculator_params)
    end
  end

  private

  def calculator_params
    params[:calculator].to_h.merge(locale: I18n.locale)
  end

  def load_variables
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
  end

  def set_locale
    I18n.locale = params[:calculator] && params[:calculator][:locale] || "imperial"
  end
end
