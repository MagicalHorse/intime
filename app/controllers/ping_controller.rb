# encoding: utf-8
class PingController < ApiBaseController
  before_filter :auth_api2
  def mock
    render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{      
      }
     }
  end
end
