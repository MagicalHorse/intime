class AddDiscountToCombos < ActiveRecord::Migration
  def change
  	 add_column :combos, :has_discount, :boolean, :default => false
  	 add_column :combos, :discount, :decimal, :precision => 10, :scale => 1
  	 add_column :combos, :is_public, :boolean, :default => true  
  end
end
