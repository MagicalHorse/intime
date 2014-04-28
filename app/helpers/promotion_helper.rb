# encoding: utf-8
module PromotionHelper
  def show_public_code?(p)
    return false if p[:publicCode].nil?||p[:publicCode].empty?
    true
  end
end
