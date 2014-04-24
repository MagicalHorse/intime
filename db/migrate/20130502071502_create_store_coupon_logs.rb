# encoding: utf-8
class CreateStoreCouponLogs < ActiveRecord::Migration
  def change
    create_table :store_coupon_logs do |t|
      t.integer :type
      t.string :code

      t.timestamps
    end
  end
end
