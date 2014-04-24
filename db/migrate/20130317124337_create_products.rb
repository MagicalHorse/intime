# encoding: utf-8
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :desc
      t.decimal :price
      t.string :recommendreason
      t.integer :status
      t.references :store
      t.references :tag
      t.integer :sortorder
      t.references :user

      t.timestamps
    end
    add_index :products, :store_id
    add_index :products, :tag_id
    add_index :products, :user_id
  end
end
