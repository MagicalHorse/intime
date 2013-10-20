# encoding: utf-8
module Front::RmasHelper

  def reason_options(reasons)
    reasons.map do |reason|
      [reason['reason'], reason['reason']]
    end.unshift(['请选择退货理由', ''])
  end
end
