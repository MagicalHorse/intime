# encoding: utf-8
class AddBrandCategoryName < ActiveRecord::Migration
  def up
  	 add_column :combo_products, :brand_name, :string 
  	 add_column :combo_products, :category_name, :string 
  end

  def down
  	 remove_column :combo_products, :brand_name, :string 
  	 remove_column :combo_products, :category_name, :string 
  end
end
