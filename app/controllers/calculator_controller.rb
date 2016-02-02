class CalculatorController < ApplicationController
  before_filter :load_vars

  def index
    return redirect_to calculator_path(
      locale: params[:set_locale],
      calculator: params[:calculator]
    ) if params[:set_locale]

    @calculator = Calculator.new(params[:calculator])

    if request.post? && params[:calculator]
      if @calculator.valid?
        flash[:notice] = "Calculation successful."
      else
        flash[:alert] = "Calculation unsuccessful. Please fill in all fields appropriately."
      end
      redirect_to calculator_path(
        calculator: params[:calculator],
        locale: @calculator.locale
      )
    end
  end

  private

  def load_vars
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
  end
end
