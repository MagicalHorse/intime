# encoding: utf-8
class StoreCoupon < ActiveRecord::Base
  attr_accessible :amount, :code, :status, :userid, :validenddate, :validstartdate, :vipcard,:coupontype,:islimitonce
  
  class<<self
    def sync_one(msg,type)
      return if msg.nil?
      coupon_old = self.find_by_code(msg[:code])
      return unless coupon_old.nil?
      self.create(:code=>msg[:code],:status=>msg[:status],:amount=>msg[:amount],:userid=>msg[:userid] \
              ,:validstartdate=>msg[:validstartdate] \
              ,:validenddate=>msg[:validenddate] \
              ,:vipcard=>msg[:vipcard] \
              ,:coupontype=>type  \
              ,:islimitonce=>msg[:islimitonce])
      
    end
  end
end
