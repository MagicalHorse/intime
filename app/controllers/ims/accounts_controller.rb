class Ims::AccountsController < Ims::BaseController
  skip_before_filter :wx_auth!
  
  # 我的账号
  def mine
    # 获取当前的用户账号
    @account = nil
  end

  # new
  def new
    @phone = "187****1111"
  end

  # 重发短信
  def resend_sms
    # 发送短信的ajax
  end

  # 绑定用户
  def create
    session[:user_id]
  end

  # 设置密码
  def create_password
    params[:password]

  end

  # 重置密码
  def reset_password
    params[:old_password]
    params[:new_password]
  end

end