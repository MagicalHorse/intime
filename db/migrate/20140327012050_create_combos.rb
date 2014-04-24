# encoding: utf-8
class CreateCombos < ActiveRecord::Migration
  def change
    create_table :combos do |t|
      t.integer :remote_id
      t.string :private_to, :combo_type
      t.text :desc
      t.decimal :price, :precision => 10, :scale => 1  
      t.timestamps
    end
  end
end
