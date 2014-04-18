# encoding: utf-8
module Mini::ApplicationHelper
  def card_orders_status status_id
    case status_id
    when 0 then "未操作"
    when 1 then "已领取"
    when 2 then "已拒收"
    when 3 then "已转赠"
    when 4 then "已充值自用"
    when 5 then "已赠送"
    end
  end

end