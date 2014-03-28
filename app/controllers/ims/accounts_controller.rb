# encoding: utf-8
class Ims::AccountsController < Ims::BaseController
  before_filter :validate_sms!, only: [:new, :create, :reset_password]
  layout "ims/user"
  # 我的资金账号
  def mine
    # API_NEED: 获取当前的用户资金账号：
    data = Ims::Giftcard.my(request)[:data]
    current_user.isbindcard = data[:is_binded]
    current_user.card_no = data[:phone]
    @amount = data[:amount]
  end

  # 填待验证手机号页面
  def phone_page
    redirect_to verify_phone_ims_accounts_path if current_user.isbindcard
  end

  # 验证手机号页面
  def verify_phone
    @phone = current_user.identify_phone
    generate_sms
  end

  # 验证短信页面
  def verfiy_sms_code
    if params[:sms_code].present? && current_user.sms_code.to_i == params[:sms_code].to_i
      current_user.verified_phone = current_user.identify_phone
      redirect_to current_user.back_url
    else
      render :verify_phone
    end
  end

  # 重发短信
  def resend_sms
    generate_sms
    render nothing: true
  end

  # 手机验证通过，填写支付密码页面
  def new
    # API_NEED: 通过当前手机号，得知手机已经开户，把手机号绑定当前用户
    result = Ims::Giftcard.bind(request, phone: params[:phone])
    if result[:isSuccessful]
      if current_user.will_charge_no.present?
        # 成功绑定老账号，且需要充值一张卡
        redirect_to recharge_ims_card_path(current_user.will_charge_no)
      else
        # 成功绑定老账号，则跳转至登录页面
        redirect_to mine_ims_accounts_path
      end
    end
  end

  # 绑定用户
  def create
    # API_NEED: 创建资金账户
    # 此接口需要支持能同时充值一张充值卡、如果此用户是买卡后进行的绑卡，需要将当时所购卡，进行充值
    result = Ims::Giftcard.create(request, {phone: current_user.verified_phone, pwd: params[:pwd], charge_no: current_user.will_charge_no, identity_no: current_user.identity_no })
    if result[:isSuccessful]
      redirect_to mine_ims_accounts_path
    else
      # 如果不成功，跳回密码页面
      redirect_to new_ims_account_path
    end
  end

  # 重置密码
  def reset_password
    # API_NEED: 重置资金账户密码
    Ims::Giftcard.resetpwd(request, {pwd_new: params[:newpwd]})
  end

  # 修改密码
  def change_password
    # API_NEED: 修改资金账户密码
    Ims::Giftcard.changepwd(request, {pwd_new: params[:newpwd], pwd_old: params[:oldpwd]})
  end

  # 用于扫描的页面
  def scan_page
    # API_NEED: 扫卡后的回调接口？用于关闭当前页面
    @code
  end

end