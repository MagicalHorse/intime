# encoding: utf-8
class Ims::AuthsController < ActionController::Base

  # 在微信端验证后，客户端的响应页面
  def show
    if (code = params[:code]).present?
      json_resp = get_access_token(code)
      open_id = json_resp['openid']
      access_token = json_resp["access_token"]
      expires_in = json_resp["expires_in"]
      back_url = params[:back_url]
      if params[:env] == "test"
        redirect_to test_ims_auth_url(host: "114.215.179.76", open_id: open_id, access_token: access_token, expires_in: expires_in, back_url: back_url)
      else
        session[:wx_openid] = open_id
        cookies[:user_access_token] = { value: access_token, expires: (expires_in - 100).seconds.from_now.utc }
        get_token_from_api(request)
        redirect_to (session[:back_url] || back_url)
        session.delete(:back_url)
      end
    else
      render text: '需要授权'
    end
  end

  def test
    open_id = params[:open_id]
    access_token = params[:access_token]
    expires_in = params[:expires_in]
    back_url = params[:back_url]
    session[:wx_openid] = open_id
    cookies[:user_access_token] = { value: access_token, expires: (expires_in.to_i - 100).seconds.from_now.utc }
    get_token_from_api(request)
    redirect_to (session[:back_url] || back_url)
    session.delete(:back_url)
  end

  private

  def get_token_from_api(request)
    user_hash = API::LoginRequest.post(request, {
      :outsiteuid       => session[:wx_openid],
      :outsitetype      => 4,
      :outsitetoken     => Ims::Weixin.access_token
    })
    session[:user_token] = user_hash[:data][:token]
    cookies[:user_token] = { value: user_hash[:data][:token], expires: Time.now.utc + 19.minutes }
    user = Ims::User.new({
      :id => user_hash[:data][:id],
      :email => user_hash[:data][:email],
      :level => user_hash[:data][:level],
      :nickname => user_hash[:data][:nickname],
      :mobile => user_hash[:data][:mobile],
      :isbindcard => user_hash[:data][:isbindcard],
      :logo => user_hash[:data][:logo],
      :operate_right => user_hash[:data][:operate_right],
      :token => user_hash[:data][:token],
      :store_id => user_hash[:data][:associate_id],
      :max_comboitems => user_hash[:data][:max_comboitems]
    })

    session[:current_wx_user] = user
  end

  def get_access_token(code, flag = 0)
    flag += 1
    resp = RestClient.get("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{Settings.wx.appid}&secret=#{Settings.wx.appsecret}&code=#{code}&grant_type=authorization_code")
    json_resp = ActiveSupport::JSON.decode(resp)
    if flag <= 3 && json_resp["access_token"].blank?
      get_access_token(code, flag)
    elsif json_resp["access_token"]
      json_resp
    else
      $logger.error("获取access_token错误")
    end
  end

end
