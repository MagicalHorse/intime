# encoding: utf-8
class Ims::AuthsController < ActionController::Base

  # 在微信端验证后，客户端的响应页面
  def show
    if params[:code]
      resp = RestClient.get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Settings.wx.appid}&secret=#{Settings.wx.appsecret}&code=#{params[:code]}&grant_type=authorization_code")
      json_resp = ActiveSupport::JSON.decode(resp)
      session[:wx_openid] = json_resp['openid']
      session[:user_access_token] = json_resp["access_token"]
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
    session[:user_token] = user_hash[:data][:token]
    user = Ims::User.new({
      :id => user_hash[:data][:id],
      :email => user_hash[:data][:email],
      :level => user_hash[:data][:level],
      :nickname => user_hash[:data][:nickname],
      :mobile => user_hash[:data][:mobile],
      :isbindcard => user_hash[:data][:isbindcard],
      :logo => user_hash[:data][:logo],
      :level => user_hash[:data][:level],
      :operate_right => user_hash[:data][:operate_right],
      :token => user_hash[:data][:token]
      })

    session[:current_wx_user] = user
  end
end