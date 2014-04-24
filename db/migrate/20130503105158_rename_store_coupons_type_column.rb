# encoding: utf-8
class RenameStoreCouponsTypeColumn < ActiveRecord::Migration
  def up
    rename_column :store_coupons, :type, :coupontype
    rename_column :store_coupon_logs, :type, :coupontype
  end

  def down
    rename_column :store_coupons, :coupontype, :type
    rename_column :store_coupon_logs, :coupontype, :type
  end
end
