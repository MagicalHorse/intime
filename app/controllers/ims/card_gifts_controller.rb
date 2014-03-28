# 作为礼品送给别的礼品卡
class Ims::CardGiftontroller < Ims::BaseController

  def index
    # API_NEED: 查看赠送给当前用户的礼品卡列表
    @data = Ims::Giftcard.create(request, type: 1)
  end

  def show
    # API_NEED: 查看某张赠送中的礼品卡
    @card
  end

  # 检查手机号页面
  def phone_page
    
  end

  # 重发短信
  def resend_sms
    # API_NEED: 发送手机验证码（用于查看赠送礼品卡）
    # 发送短信的ajax
  end

  # 再次赠送
  def present
    # API_NEED: 再次赠送礼品卡
    params[:card_id]
    params[:user_id]
  end

end