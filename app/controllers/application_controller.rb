class ApplicationController < ActionController::Base
  PAGE_ALL_SIZE = 1000
 
  protected
  def error_500
    {:isSuccessful=>false,
      :message =>'internal failed problem.',
      :statusCode =>'500'
     }.to_json()
  end
end
