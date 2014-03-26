class Ims::AuthsController < ActionController::Base

  # 在微信端验证后，客户端的响应页面
  def show
    if params[:code]
      resp = RestClient.get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Settings.wx.appid}&secret=#{Settings.wx.appsecret}&code=#{params[:code]}&grant_type=authorization_code")
      session[:wx_openid] = ActiveSupport::JSON.decode(resp)['openid']
      #TODO 换取user_id
      get_token_from_api(request)
      redirect_to session[:back_url]
      session.delete(:back_url)
    else
      render text: '需要授权'
    end
  end

  private
  def get_token_from_api(request)
    user_hash = API::LoginRequest.post(request, {
      :outsiteuid       => session[:wx_openid],
      :outsitetype      => 4,
      :outsitetoken     => Ims::Weixin.access_token
    }) 
    session[:user_token] = user_hash[:data][:refresh_token]
    session[:current_data] = user_hash[:data]
  end
end