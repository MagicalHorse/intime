# encoding: utf-8
class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :desc
      t.string :englishname
      t.string :logo
      t.string :website
      t.integer :status

      t.timestamps
    end
  end
end
