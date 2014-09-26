class Ims::AppController < ApiBaseController

  def token
    render :json=>{
      token:Ims::Weixin.access_token(params[:data])
    }
  end

end