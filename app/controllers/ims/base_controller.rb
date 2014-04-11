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
    # TODO 上线前，去掉下列判断，只保留抛异常的部分
    if request.host != "test.ngrok.com"
      session[:user_token] = nil
      get_token_from_api(request) unless session[:user_token]
    else
      raise Ims::Unauthorized if session[:user_token].blank? || cookies[:user_access_token].blank?
    end
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
      :operate_right => user_hash[:data][:operate_right],
      :token => user_hash[:data][:token],
      :store_id => user_hash[:data][:associate_id],
      :max_comboitems => user_hash[:data][:max_comboitems]
      })

    session[:current_wx_user] = user
  end

  # 生成验证短信验证码
  def generate_sms phone
    current_user.sms_code = (0..9).to_a.sample(6)
    # TODO 上线后，删除下面的模拟号码
    current_user.sms_code = 222222
    # API_NEED: 发送手机验证码（用于绑卡）
    Ims::Sms.send(request, {phone: phone, text: "验证码为：#{current_user.sms_code}"})
  end

  # 验证手机号短信
  def validate_sms!
    current_user.back_url = request.fullpath
    if current_user.other_phone
      return if (current_user.verified_other_phones || "").index current_user.other_phone.to_s
      redirect_to verify_phone_ims_accounts_path
    end
  end

  # 用户储值卡账户信息
  def user_account_info
    # API_NEED: 获取当前的用户资金账号：
    data = Ims::Giftcard.my(request)[:data]
    if data.present?
      current_user.isbindcard = data[:is_binded]
      current_user.card_no = data[:phone]
      current_user.verified_phone = data[:phone]
      current_user.amount = data[:amount]
    else
      current_user.isbindcard = false
    end
  end

end