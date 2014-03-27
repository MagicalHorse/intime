class CreateComboProducts < ActiveRecord::Migration
  def change
    create_table :combo_products do |t|
    	 t.integer :remote_id, :combo_id
      t.string :img_url, :combo_type
      t.timestamps
    end
  end
end
