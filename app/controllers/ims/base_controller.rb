class Ims::BaseController < ApplicationController
  layout 'ims'
  before_filter :wx_auth! unless Rails.env.development?
  
  rescue_from Ims::Unauthorized do
    redirect_to(URI::HTTPS.build([nil, "open.weixin.qq.com", nil, "/connect/oauth2/authorize", {appid: Settings.wx.appid, redirect_uri: URI.escape("http://#{Settings.wx.backdomain}/ims/auth"), response_type: 'code', scope: 'snsapi_base', state: "STATE"}.to_param, 'wechat_redirect']).to_s)
    session[:back_url] = request.url
  end
  
  def backurl
    session[:back_url]||ims_cards_path
  end
  
  def current_user_id
    session[:inner_user_id]
  end
  
  def wx_auth!
    raise Ims::Unauthorized unless session[:wx_openid]
  end

  private

  # 生成验证短信验证码
  def generate_sms
    session[:sms_code] = (0..9).to_a.sample(6)
  end

  # 验证短信内容，创建一次访问许可
  def validate_sms!
    session[:sms_code] = params[:sms_code]
  end

end