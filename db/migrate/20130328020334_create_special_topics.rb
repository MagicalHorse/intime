# encoding: utf-8
class CreateSpecialTopics < ActiveRecord::Migration
  def change
    create_table :special_topics do |t|
      t.string :name
      t.string :desc
      t.integer :status

      t.timestamps
    end
  end
end
