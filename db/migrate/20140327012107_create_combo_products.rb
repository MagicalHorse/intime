# encoding: utf-8
class CreateComboProducts < ActiveRecord::Migration
  def change
    create_table :combo_products do |t|
    	 t.integer :remote_id, :combo_id
      t.string :img_url, :product_type
      t.decimal :price, :precision => 10, :scale => 1  
      t.timestamps
    end
  end
end
