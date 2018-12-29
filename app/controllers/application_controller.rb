class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_locale

  protected

  def set_locale
    I18n.locale = params[:locale] || :metric
  end
end
