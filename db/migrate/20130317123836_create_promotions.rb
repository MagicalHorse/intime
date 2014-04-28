# encoding: utf-8
class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :desc
      t.integer :status
      t.references :store
      t.datetime :begindate
      t.datetime :enddate
      t.integer :limitcoupons
      t.references :tag
      t.boolean :istop
      t.boolean :hasprod
      t.references :user
      
      t.timestamps
    end
    add_index :promotions, :store_id
    add_index :promotions, :tag_id
  end
end
