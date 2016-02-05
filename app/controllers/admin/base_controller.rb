require 'digest'

class Admin::BaseController < ApplicationController
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      session[:admin] = true
      md5_of_password = Digest::MD5.hexdigest(password)
      if Rails.env == "production"
        #staging & production server code
        username == ENV['APP_USERNAME'] && password == ENV['APP_PASSWORD']
      else
        #development server code
        username == 'admin' && md5_of_password == '21232f297a57a5a743894a0e4a801fc3'
      end
    end
  end

  def clear_cache
    expire_page "/"
    expire_page "/calculator"
    expire_page theory_path
    expire_page disclaimer_path
    expire_page definitions_path
  end
end
