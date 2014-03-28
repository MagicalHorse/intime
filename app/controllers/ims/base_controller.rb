# encoding: utf-8
class Ims::BaseController < ApplicationController
  layout 'ims'
  before_filter :wx_auth!
  helper_method :current_user

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

  def current_user
    @current_wx_user ||= session[:current_wx_user]
  end

  def wx_auth!
    get_token_from_api(request) unless session[:user_token]
  end

  private

  def get_token_from_api(request)
    user_hash = API::LoginRequest.post(request, {
      :outsiteuid       => Settings.wx.open_id,
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

  # 生成验证短信验证码
  def generate_sms
    current_user.sms_code = (0..9).to_a.sample(6)
    current_user.sms_code = 111111
    # API_NEED: 发送手机验证码（用于绑卡）
    Ims::Sms.send(request, {phone: current_user.identify_phone, text: "验证码为：#{current_user.sms_code}"})
  end

  # 验证手机，对访问进行放行，否则进入手机验证页面
  def validate_sms!
    current_user.back_url = request.path
    unless current_user.verified_phone.present?
      redirect_to verify_phone_ims_accounts_path
    end
  end

end