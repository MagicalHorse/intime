# encoding: utf-8

class Ims::BaseController < ApplicationController
  layout 'ims/ims'
  before_filter :setup_group_id, :setup_payment_type, :wx_auth!
  helper_method [:current_user, :track_options]

  rescue_from Ims::Unauthorized do
    back_url = "http://#{Settings.wx.backdomain}/ims/auth?back_url=#{request.url}"
    if Rails.env.production?
      back_url = URI.escape(back_url)
    else
      back_url = URI::HTTP.build([nil,'i.intime.com.cn',nil,"/ims/auth/forward",{raw_url:back_url}.to_param,nil]).to_s
    end
    weixin_key
    redirect_to(URI::HTTPS.build([nil, "open.weixin.qq.com", nil, "/connect/oauth2/authorize", {appid: @weixin_key[:app_id], redirect_uri: back_url, response_type: 'code', scope: 'snsapi_base', state: ""}.to_param, 'wechat_redirect']).to_s)
  end

  def backurl
    session[:back_url] || ims_cards_path
  end

  def current_user_id
    session[:inner_user_id]
  end

  def current_user
    @current_wx_user = session[:current_wx_user]
  end

  def wx_auth!
    session[:back_url] = request.url
    # 提供测试环境下的mockup访问
    if Rails.env == "development"
      get_token_from_api(request) unless session[:user_token]
    else
      $logger.info("access_token: #{cookies[:user_access_token]}")
      if is_mobile
        raise Ims::Unauthorized  if session[:wx_openid].blank?
        redirect_to get_user_token_ims_auth_path(back_url: request.url) if cookies[:user_token].blank?
      else
        if session[:wx_openid].blank?
          redirect_to login_ims_weixins_path(group_id: session[:group_id], redirect_url: request.fullpath)
        elsif session[:current_wx_user].blank? || cookies[:user_token].blank? # cookies[:user_token].blank? 是为了24小时cookie过期后，重新获取ims token，因为这个涉及到了用户升级和降级的问题。
          redirect_to get_user_token_ims_auth_path(back_url: request.url)
        end
      end
    end
  end

  def track_options
    params||{}
  end

  private

  def is_mobile
    request.user_agent.downcase.match(/(iPhone|iPod|Android|ios|Windows Phone|mobile)/i).present?
  end

  def verify_weixin_user_access_token
    raise Ims::Unauthorized if cookies[:user_access_token].blank?
  end

  def alipay_key
    @alipay_key = API::Environment.getalipaykey(request, groupid: session[:group_id])[:data]
  end

  def weixin_key
    @weixin_key = API::Environment.getweixinkey(request, groupid: session[:group_id])[:data]
  end

  def setup_group_id
    if params[:group_id]
      session[:group_id] = params[:group_id]
    elsif session[:group_id].nil?
      session[:group_id] = 1
    end
  end

  def setup_payment_type
    if request.referer.blank?
      session[:itpm] = params[:itpm]
    else
      session[:itpm] ||= params[:itpm]
    end
  end

  def get_token_from_api(request)
    user_hash = API::LoginRequest.post(request, {
      :outsiteuid       => Settings.wx.open_id,
      :outsitetype      => 4
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
    current_user.sms_code = (0..9).to_a.sample(6).join.rjust(6,"0")
    # API_NEED: 发送手机验证码（用于绑卡）
    Ims::Sms.send(request, {phone: phone, text: "验证码：#{current_user.sms_code}，请填写验证码并完成操作。【请勿向任何人提供您收到的短信验证码】【迷你银】"})
  end

  # 验证手机号短信
  def validate_sms!
    current_user.back_url = request.fullpath
    if current_user.other_phone
      return if current_user.other_phone == current_user.verified_phone
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
      current_user.other_phone = data[:phone]
      current_user.amount = data[:amount]
    else
      current_user.isbindcard = false
    end
  end

  def upload_image(data)
    FileUtils.mkdir("#{Rails.root}/public/uploads") if !File.exist?("#{Rails.root}/public/uploads")
    file_name = 'uploads/' + Time.now.to_i.to_s + '.jpg'
    File.open('public/' + file_name, 'wb') do|f|
      f.write(Base64.decode64(data))
    end
    [File.new("#{Rails.root}/public/#{file_name}", 'rb'), file_name]
  end

end
