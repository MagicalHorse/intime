class Ims::CardsController < Ims::BaseController
  layout "ims/user"

  # 充值历史
  def index

  end

  # 给自己充值
  def recharge
    if current_user.isbindcard
      # API_NEED: 充值礼品卡接口
      @data = Ims::Giftcard.recharge(request, charge_no: params[:charge_no])
      # 置空欲充值卡号
      current_user.will_charge_no = nil
    else
      # 如果未绑定，则跳至绑卡页面
      current_user.will_charge_no = params[:charge_no]
      redirect_to new_ims_account_path
    end
  end

  # 获赠礼品卡
  def gift_page
    
  end

  # 赠送给别人
  def send
    # API_NEED: 赠送礼品卡接口
    @result = Ims::Giftcard.send(request, charge_no: params[:charge_no], comment: params[:comment], phone: params[:phone])
  end

  # 接受
  def accept
    # API_NEED: 接受礼品卡
    params[:card_id]
  end

  # 不接受，归还原有用户
  def return
    # API_NEED: 拒收并退回礼品卡
    params[:card_id]
  end

end