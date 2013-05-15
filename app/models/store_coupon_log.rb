class StoreCouponLog < ActiveRecord::Base
  attr_accessible :code, :coupontype,:storeno,:receiptno
end
