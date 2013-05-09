class StoreCoupon < ActiveRecord::Base
  attr_accessible :amount, :code, :status, :userid, :validenddate, :validstartdate, :vipcard,:coupontype
  
  class<<self
    def sync_one(msg,type)
      return if msg.nil?
      exist_coupon = self.find_or_initialize_by_code(msg[:code])
      exist_coupon.status= msg[:status]
      exist_coupon.code =msg[:code]
      exist_coupon.amount= msg[:amount]
      exist_coupon.userid= msg[:userid]
      exist_coupon.validstartdate=msg[:validstartdate]
      exist_coupon.validenddate=msg[:validenddate]
      exist_coupon.vipcard= msg[:vipcard]
      exist_coupon.coupontype=type
      exist_coupon.save
    end
  end
end
