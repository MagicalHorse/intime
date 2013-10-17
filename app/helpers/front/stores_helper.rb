module Front::StoresHelper
  def format_time_range(promotion)
    [
      promotion.startdate.to_time.strftime('%Y.%m.%d'),
      promotion.enddate.to_time.strftime('%Y.%m.%d')
    ].join('-')
  end
end
