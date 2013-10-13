module Front::OrdersHelper

  STATUST = {
    unpaid:     0,    # 创建未支付
    paid:       1,    # 已支付
    approval:   2,    # 订单审核通过
    unshipped:  14,   # 订单准备发货
    shipped:    15,   # 订单已发货
    received:   16,   # 用户已签收
    rejected:   10    # 用户拒收
  }
end
