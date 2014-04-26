# encoding: utf-8
class CreateCouponRebateLogs < ActiveRecord::Migration
  def change
    create_table :coupon_rebate_logs do |t|
      t.string :code
      t.integer :coupontype
      t.string :storeno
      t.string :receiptno

      t.timestamps
    end
  end
end
