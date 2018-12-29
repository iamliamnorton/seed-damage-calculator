class Admin::BaseController < ApplicationController
  before_action :authenticate

  def authenticate
    return unless Rails.env.production?

    authenticate_or_request_with_http_basic('Administration') do |username, password|
      session[:admin] = true
      username == ENV['APP_USERNAME'] && password == ENV['APP_PASSWORD']
    end
  end
end
