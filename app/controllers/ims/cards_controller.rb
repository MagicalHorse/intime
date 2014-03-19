class Ims::CardsController < Ims::BaseController

  # 给自己充值
  def recharge
    # API_NEED: 充值礼品卡接口
    # 1、入参：卡号、当前用户id
    # 2、返回：卡号、金额、是否成功

    if "has no account"
      redirect_to "绑卡页面"
    end
  end

  # 赠送给别人
  def present
    # API_NEED: 赠送礼品卡接口
    # 1、入参：卡号、当前用户id、赠与的用户手机号
    # 2、返回：是否成功
  end

end