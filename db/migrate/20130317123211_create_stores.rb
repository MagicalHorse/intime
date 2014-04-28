# encoding: utf-8
class CreateStores < ActiveRecord::Migration
  def change

    create_table :stores do |t|
      t.string :name
      t.string :desc
      t.string :address
      t.string :telephone
      t.decimal :lngit
      t.decimal :latit
      t.integer :status
      t.decimal :gpslngit
      t.decimal :gpslatit
      t.decimal :gpsalt
      t.references :company
      t.references :region

      t.timestamps
    end
    add_index :stores, :company_id
    add_index :stores, :region_id
   
  end
end
