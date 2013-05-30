class AddStatusToStoreCouponLog < ActiveRecord::Migration
  def change
    add_column :store_coupon_logs, :status, :integer
  end
end
