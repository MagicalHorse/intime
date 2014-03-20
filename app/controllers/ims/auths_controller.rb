class Ims::AuthsController < ActionController::Base
  def show
    if params[:code]
      resp = RestClient.get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Settings.wx.appid}&secret=#{Settings.wx.appsecret}&code=#{params[:code]}&grant_type=authorization_code")
      session[:wx_openid] = ActiveSupport::JSON.decode(resp)['openid']
      #TODO 换取user_id
#      session[:inner_user_id] = 
      redirect_to session[:back_url]
      session.delete(:back_url)
    else
      render text: '需要授权'
    end
  end
end