# encoding: utf-8
class Ims::AccountsController < Ims::BaseController
  before_filter :validate_sms!, only: [:new, :create, :create_password, :reset_password, :change_password]
  layout "ims/user"
  # 我的资金账号
  def mine
    # API_NEED: 获取当前的用户资金账号：
    data = Ims::Giftcard.create(request)
    # 1、是否绑卡
    # 2、已经绑卡，需要返回卡余额、卡号
    @is_binded = data[:is_binded] #|| true
    @amount = data[:amount] #|| 100
  end

  # 绑定系列：验证手机号页面
  def verify_phone
    session[:phone] = params[:phone]
    generate_sms
    # API_NEED: 发送手机验证码（用于绑卡）
    Ims::Sms.send(request, {phone: session[:phone], text: "#{session[:sms_code]}"})
    @phone = "#{session[:phone][0, 3]}****#{session[:phone][7, 4]}"
  end

  # 重发短信
  def resend_sms
    generate_sms
    # API_NEED: 发送手机验证码（用于绑卡）
    Ims::Sms.send(request, {phone: session[:phone], text: "#{session[:sms_code]}"})
    render nothing: true
  end

  # 手机验证通过，增加密码
  def new
    # 通过当前手机号，得知手机已经开户，把手机号绑定当前用户
    if false
      session[:phone] = nil
      redirect_to mine_ims_accounts_path
    end
  end

  # 绑定用户
  def create
    # API_NEED: 创建资金账户
    # 此接口需要支持能同时充值一张充值卡、如果此用户是买卡后进行的绑卡，需要将当时所购卡，进行充值
    Ims::Giftcard.create(request, {phone: session[:phone], pwd: params[:pwd]})
    if true
      p "如果保存成功，则跳往个人主页"
      session[:sms_code], session[:phone] = nil, nil
      redirect_to mine_ims_accounts_path
    else
      # 如果不成功，跳回密码页面
      redirect_to new_ims_account_path
    end
  end

  # 重置密码
  def reset_password
    # API_NEED: 重置资金账户密码
    Ims::Giftcard.resetpwd(request, {oldpwd: params[:oldpwd], newpwd: params[:newpwd]})
  end

  # 修改密码
  def change_password
    # API_NEED: 修改资金账户密码
    Ims::Giftcard.changepwd(request, {newpwd: params[:newpwd]})
  end

  # 用于扫描的页面
  def scan_page
    # API_NEED: 扫卡后的回调接口？用于关闭当前页面
    @code
  end

end