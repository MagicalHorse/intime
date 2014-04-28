# encoding: utf-8
class CreateComboPics < ActiveRecord::Migration
  def change
    create_table :combo_pics do |t|
    	 t.integer :remote_id
    	 t.integer :combo_id
      t.string :url
      t.timestamps
    end
  end
end
