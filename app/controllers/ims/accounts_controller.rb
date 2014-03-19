class Ims::AccountsController < Ims::BaseController
  
  # 我的资金账号
  def mine
    # API_NEED: 获取当前的用户资金账号：
    # 1、是否绑卡
    # 2、已经绑卡，需要返回卡余额、卡号
    @account = nil
  end

  # 填写用户手机号页面
  def phone_page
  end

  # new
  def new
    # API_NEED: 发送手机验证码（用于绑卡）
    @phone = "187****1111"
  end

  # 重发短信
  def resend_sms
    # API_NEED: 发送手机验证码（用于绑卡）
  end

  # 绑定用户
  def create
    # API_NEED: 创建资金账户
    # 1、此接口需要支持能同时充值一张充值卡
    #   如果此用户是买卡后进行的绑卡，需要将当时所购卡，进行充值
    session[:user_id]
  end

  # 设置密码
  def create_password
    # API_NEED: 设置资金账户初始密码
    params[:password]
  end

  # 重置密码
  def reset_password
    # API_NEED: 重置资金账户密码
    params[:old_password]
    params[:new_password]
  end

  # 修改密码
  def change_password
    # API_NEED: 修改资金账户密码
    params[:old_password]
    params[:new_password]
  end

  # 用于扫描的页面
  def scan_page
    @code
    # API_NEED: 扫卡后的回调接口？用于关闭当前页面
  end

end