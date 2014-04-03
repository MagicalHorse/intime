# encoding: utf-8
class Ims::AccountsController < Ims::BaseController
  before_filter :user_account_info, only: [:mine]
  before_filter :validate_verified_phone!, only: [:new, :create]
  before_filter :validate_sms!, only: [:reset_password_page, :reset_password]
  before_filter :isbindcard!, only: [:phone_page, :verify_identify_phone]
  layout "ims/user"
  # 我的资金账号
  def mine
  end

  # ============= 新用户绑卡 ============= 》》》

  # 填待验证手机号页面
  def phone_page
  end

  # 验证手机号，进行绑定账号
  def verify_identify_phone
    current_user.identify_phone = params[:phone] if params[:phone].present?
    @phone = current_user.identify_phone.to_s
    if @phone.blank?
      redirect_to phone_page_ims_accounts_path, notice: "请填写手机号"
      return
    else
      # API_NEED ： 判断手机号是否已经绑定
      is_binded = Ims::Giftcard.isbind(request, phone: @phone)[:is_binded]
      # 如果当前手机号是否是未注册用户，则判断是否有待充值的卡，否则跳转到填写手机号页面，通知他新用户不能绑定
      if !is_binded and current_user.will_charge_no.blank?
        redirect_to phone_page_ims_accounts_path, notice: "目前只允许老用户进行绑定"
        return
      end
    end 
    generate_sms @phone
    @path = verfiy_identify_sms_code_ims_accounts_path
    render :verify_phone
  end

  # 验证短信页面
  def verfiy_identify_sms_code
    if params[:sms_code].present? && current_user.sms_code.to_i == params[:sms_code].to_i
      current_user.verified_phone = current_user.identify_phone
      redirect_to new_ims_account_path
    else
      redirect_to verify_identify_phone_ims_accounts_path
    end
  end

  # 手机验证通过，填写支付密码页面
  def new
    # API_NEED: 通过当前手机号，得知手机已经开户，把手机号绑定当前用户
    result = Ims::Giftcard.bind(request, phone: params[:phone])
    if result[:isSuccessful]
      # 成功绑定老用户
      if current_user.will_charge_no.present?
        # 如果需要充值一张卡
        redirect_to recharge_ims_card_path(current_user.will_charge_no)
      else
        redirect_to mine_ims_accounts_path
      end
    end
  end

  # 绑定用户
  def create
    # API_NEED: 创建资金账户
    # 此接口需要支持能同时充值一张充值卡、如果此用户是买卡后进行的绑卡，需要将当时所购卡，进行充值
    result = Ims::Giftcard.create(request, {phone: current_user.verified_phone, pwd: params[:pwd], charge_no: current_user.will_charge_no, identity_no: current_user.identity_no })
    if true# result[:isSuccessful]
      current_user.isbindcard = true
      redirect_to current_user.back_url || mine_ims_accounts_path
    else
      # 如果不成功，跳回密码页面
      redirect_to new_ims_account_path
    end
  end

  # 《《《 ============= 新用户绑卡 =============

  # 验证指定手机号页面
  def verify_phone
    @phone = current_user.other_phone.to_s
    generate_sms @phone
    @path = verfiy_sms_code_ims_accounts_path
    render :verify_phone
  end

  # 验证指定手机短信页面
  def verfiy_sms_code
    if params[:sms_code].present? && current_user.sms_code.to_i == params[:sms_code].to_i
      current_user.verified_other_phones = "#{current_user.verified_other_phones},#{current_user.other_phone}"
      redirect_to current_user.back_url
    else
      redirect_to verify_phone_ims_accounts_path
    end
  end

  # 重发短信
  def resend_sms
    generate_sms params[:phone]
    render nothing: true
  end

  # 重置密码
  def reset_password
    # API_NEED: 重置资金账户密码
    result = Ims::Giftcard.resetpwd(request, {pwd_new: params[:newpwd]})
    if true#result[:isSuccessful]
      redirect_to mine_ims_accounts_path
    else
      redirect_to reset_password_page_ims_accounts_path
    end
  end

  # 修改密码
  def change_password
    # API_NEED: 修改资金账户密码
    result = Ims::Giftcard.changepwd(request, {pwd_new: params[:newpwd], pwd_old: params[:oldpwd]})
    if result[:isSuccessful]
      redirect_to mine_ims_accounts_path
    else
      redirect_to change_password_page_ims_accounts_path
    end
  end

  private

  # 已经绑卡成功，不能进入某些页面
  def isbindcard!
    redirect_to mine_ims_accounts_path if current_user.isbindcard
  end

  # 如果没有认证的手机号，则跳回认证手机号页面
  def validate_verified_phone!
    redirect_to verify_identify_phone_ims_accounts_path if current_user.verified_phone.blank? 
  end

end