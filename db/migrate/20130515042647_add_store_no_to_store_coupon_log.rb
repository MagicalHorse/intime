# encoding: utf-8
class AddStoreNoToStoreCouponLog < ActiveRecord::Migration
  def change
        change_table :store_coupon_logs do |t|
          t.string :storeno
          t.string :receiptno
        end
  end
end
