# encoding: utf-8
class CreateProd2ProRelationTable < ActiveRecord::Migration
  def change
    create_table :promotions_products do |t|
      t.references :promotion
      t.references :product
      
      t.timestamps
    end
  end
end
