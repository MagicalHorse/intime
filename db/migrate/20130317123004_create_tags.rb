# encoding: utf-8
class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :desc
      t.integer :sortorder
      t.integer :status

      t.timestamps
    end
  end
end
