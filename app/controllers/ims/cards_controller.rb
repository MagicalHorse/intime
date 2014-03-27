class Ims::CardsController < Ims::BaseController

  # 充值历史
  def index
    
  end

  # 给自己充值
  def recharge
    # API_NEED: 充值礼品卡接口
    # 1、入参：卡号、当前用户id
    # 2、返回：卡号、金额、是否成功
    @data = Ims::Giftcard.create(request, type: [2 ,3, 5])
    

    if "has no account"
      # "绑卡页面"
      redirect_to ""
    end
  end

  # 赠送给别人
  def present
    # API_NEED: 赠送礼品卡接口
    # 1、入参：卡号、当前用户id、赠与的用户手机号
    # 2、返回：是否成功
  end

end