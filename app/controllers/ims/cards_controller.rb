class Ims::CardsController < Ims::BaseController
  before_filter :user_account_info, only: [:gift_page]
  before_filter :validate_sms!, only: [:give_page, :refuse, :recharge]
  layout "ims/user"

  # 给自己充值
  def recharge
    @charge_no = params[:charge_no]
    if current_user.isbindcard
      # API_NEED: 充值礼品卡接口
      @result = Ims::Giftcard.recharge(request, charge_no: @charge_no)
      # 置空欲充值卡号
      current_user.will_charge_no = nil
      # API_NEED: 根据礼品卡号，获取礼品卡相关信息
      @card = Ims::Giftcard.detail(request, charge_no: @charge_no)["data"]
    else
      # 如果未绑定，则跳至绑卡页面
      current_user.will_charge_no = current_user.will_charge_no || @charge_no
      current_user.charge_type = params[:charge_type]
      redirect_to new_ims_account_path
    end
  end

  # 获赠礼品卡
  def gift_page
    @charge_no = params[:charge_no]
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息
    @card = Ims::Giftcard.transfer_detail(request, charge_no: @charge_no)["data"]
    current_user.other_phone = @card[:phone]
  end

  # 赠送页面
  def give_page
    @charge_no = params[:charge_no]
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息
    @card = Ims::Giftcard.transfer_detail(request, charge_no: @charge_no)["data"]
  end

  # 赠送给别人
  def give
    @charge_no = params[:charge_no]
    # API_NEED: 赠送礼品卡接口
    @result = Ims::Giftcard.send(request, charge_no: params[:charge_no], comment: params[:comment], phone: params[:phone])
  end

  # 不接受，归还原有用户
  def refuse
    # API_NEED: 拒收并退回礼品卡
    Ims::Giftcard.refuse(request, charge_no: params[:charge_no])
    redirect_to "#{gift_page_ims_cards_path}?charge_no=#{params[:charge_no]}"
  end

end