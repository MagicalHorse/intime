# encoding: utf-8
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickie
      t.string :pwd
      t.string :mobile
      t.string :email
      t.integer :status
      t.integer :level
      t.string :logo

      t.timestamps
    end
  end
end
