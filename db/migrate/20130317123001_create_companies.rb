# encoding: utf-8
class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :desc

      t.timestamps
    end
  end
end
