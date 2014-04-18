# encoding: utf-8
class Mini::WeixinsController < ApiBaseController
  skip_before_filter :auth_api, :only=>[:verify,:message]
  def verify
    render :text=>params[:echostr]
  end
  
  def message
    render :text=>''
  end
  
  def access_token
    render :json=>{
      token:Mini::Weixin.acess_token
    }
  end
end