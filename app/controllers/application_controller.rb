class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_i18n_locale_from_params

  protected

  def set_i18n_locale_from_params
    if params[:locale]
      if params[:locale].blank?
        I18n.locale = :metric
      else
        I18n.locale = params[:locale]
      end
    end
  end
end
