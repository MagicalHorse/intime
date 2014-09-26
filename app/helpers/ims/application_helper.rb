# encoding: utf-8
module Ims::ApplicationHelper
  def card_orders_status status_id
    case status_id
    when 0 then "未操作"
    when 1 then "已领取"
    when 2 then "已拒收" # 主动拒绝
    when 3 then "已转赠"
    when 4 then "已充值自用"
    when 5 then "已赠送"
    when 6 then "已拒收" # 被动拒绝
    when 7 then "赠出中"
    when 8 then "已领取"
    end
  end

  def image_url(source)
    abs_path = image_path(source)
    unless abs_path =~ /^http/
      abs_path = "#{request.protocol}#{request.host_with_port}#{abs_path}"
    end
   abs_path
  end

  def format_text(txt)
    return txt.gsub(/\r\n|\n/, "<br>")
  end

  def current_pages?(*path)
    path.any? { |path| current_page? path }
  end

end
