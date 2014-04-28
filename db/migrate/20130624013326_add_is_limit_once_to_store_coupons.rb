# encoding: utf-8
class AddIsLimitOnceToStoreCoupons < ActiveRecord::Migration
  def change
    add_column :store_coupons, :islimitonce, :boolean
  end
end
