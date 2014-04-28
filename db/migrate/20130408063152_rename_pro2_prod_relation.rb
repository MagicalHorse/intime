# encoding: utf-8
class RenamePro2ProdRelation < ActiveRecord::Migration
  def up
    rename_table 'promotions_products','products_promotions'
  end

  def down
    rename_table 'products_promotions','promotions_products'
  end
end
