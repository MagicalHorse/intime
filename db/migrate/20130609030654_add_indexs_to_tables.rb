# encoding: utf-8
class AddIndexsToTables < ActiveRecord::Migration
  def change
    add_index :wx_reply_msgs, [:rkey]
    add_index :store_coupons,[:code,:coupontype]
    add_index :cards, [:no,:utoken]
    add_index :cards, [:utoken,:isbinded]
    add_index :store_coupon_logs,:created_at
  end
end
