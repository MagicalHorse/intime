class Ims::CardsController < Ims::BaseController
  before_filter :validate_other_sms!, only: [:give_page, :refuse, :recharge]
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
      current_user.charge_type = params[:charge_type]
      redirect_to new_ims_account_path
    end
  end

  # 获赠礼品卡
  def gift_page
    @charge_no = params[:charge_no]
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息

    # 1、礼品卡编号、评论内容、礼品卡赠送的手机号、赠送礼品卡的人名
    # 2、礼品卡状态：已转赠、已经收取、已经拒收、未操作
    # 3、礼品卡价值

    current_user.other_phone = "1234"
    @card = {}
  end

  # 赠送页面
  def give_page
    @charge_no = params[:charge_no]
    # API_NEED: 根据礼品卡号，获取礼品卡相关信息

    # 1、评论内容、礼品卡赠送的手机号、赠送礼品卡的人名
    # 2、礼品卡状态：已转赠、已经收取、已经拒收、未操作
    # 3、礼品卡价值

    @card = {}
  end

  # 赠送给别人
  def give
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