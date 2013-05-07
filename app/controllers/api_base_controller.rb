class ApiBaseController < ApplicationController
  include ISAuthenticate
  before_filter :auth_api
  
  protected
  def error_500_msg(msg)
     {:isSuccessful=>false,
      :message =>msg,
      :statusCode =>'500'}.to_json()
  end
end
