class LocalesController < ApplicationController
  def create
    redirect_to calculator_path(
      calculator: calculator_params
    )
  end

  private

  def calculator_params
    (params[:calculator] || {}).merge(locale: params[:locale])
  end
end
