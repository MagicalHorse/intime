# encoding: utf-8
class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :private
      t.string :publickey
      t.integer :status
      t.string :desc

      t.timestamps
    end
  end
end
