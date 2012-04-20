require 'digest'

class Admin::BaseController < ApplicationController
  
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      session[:admin] = true
      md5_of_password = Digest::MD5.hexdigest(password)
      # The default username/password combination is admin/admin
      username == 'admin' && md5_of_password == '21232f297a57a5a743894a0e4a801fc3'
    end
  end
  
end
