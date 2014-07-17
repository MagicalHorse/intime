# encoding: utf-8

class Ims::RechargeHistroiesController < Ims::BaseController

  # 充值记录
  def index
    # API_NEED: 获取礼品卡订单的列表
    @data = Ims::Giftcard.create(request, type: 1)
  end

end
