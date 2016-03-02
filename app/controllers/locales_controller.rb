class LocalesController < ApplicationController
  def create
    redirect_to calculator_path(calculator: {
      locale: params[:locale]
    })
  end
end
