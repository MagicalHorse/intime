# 作为礼品送给别的礼品卡
class Ims::CardGiftontroller < Ims::BaseController

  def show
    @card
  end

  # 检查手机号页面
  def check_phone
    
  end

  # 重发短信
  def resend_sms
    # 发送短信的ajax
  end

  # 接受
  def accept
    params[:card_id]
  end

  # 不接受，归还原有用户
  def return
    params[:card_id]
  end

  # 再次赠送
  def give
    params[:card_id]
    params[:user_id]
  end

end