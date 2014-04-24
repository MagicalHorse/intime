# encoding: utf-8
module Front::RmasHelper

  def reason_options(reasons)
    reasons.map do |reason|
      [reason['reason'], reason['id']]
    end.unshift(['请选择退货理由', '']).push(['其他', 'other'])
  end

  def can_display_address?(status)
    API::Rma::STATUSES.values_at(:approval, :completed).include?(status.to_i)
  end

  def shipvia_options(shipvias)
    shipvias.map do |shipvia|
      [shipvia['name'], shipvia['id']]
    end
  end

  def verified?(status)
    API::Rma::STATUSES[:approval] == status.to_i
  end
end
