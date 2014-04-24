# encoding: utf-8
class CreateStoreCoupons < ActiveRecord::Migration
  def change
    create_table :store_coupons do |t|
      t.integer :status
      t.string :code
      t.decimal :amount,:precision=>10,:scale=>2
      t.integer :userid
      t.datetime :validstartdate
      t.datetime :validenddate
      t.string :vipcard
      t.integer :type

      t.timestamps
    end
  end
end
