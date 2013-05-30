class CouponRebateLog < ActiveRecord::Base
  attr_accessible :code, :coupontype, :receiptno, :storeno
end
