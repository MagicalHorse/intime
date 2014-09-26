class Ims::AppsController < ApiBaseController

  def token
    render :json=>{
      token:Ims::Weixin.access_token(params[:data])
    }
  end

end