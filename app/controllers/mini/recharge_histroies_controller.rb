# encoding: utf-8
class Mini::RechargeHistroiesController < Mini::BaseController

  # 充值记录
  def index
    # API_NEED: 获取礼品卡订单的列表
    @data = Mini::Giftcard.create(request, type: 1)
  end

end