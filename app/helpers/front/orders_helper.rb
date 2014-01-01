# encoding: utf-8
module Front::OrdersHelper

  def unpaid_orders_page?
    params[:type].to_s == API::Order::TYPES[:unpaid].to_s || params[:type].blank?
  end

  [:unreceived, :completed, :cancelled].each do |status|
    define_method "#{status.to_s}_orders_page?".to_sym do
      params[:type].to_s == API::Order::TYPES[status].to_s
    end
  end
  
  def invoice_options(invoices)
    invoices.map do |invoice|
      [invoice['name'], invoice['name']]
    end.unshift(['请选择发票明细', ''])
  end
end
