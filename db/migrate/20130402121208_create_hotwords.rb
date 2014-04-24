# encoding: utf-8
class CreateHotwords < ActiveRecord::Migration
  def change
    create_table :hotwords do |t|
      t.integer :status
      t.integer :type
      t.integer :sortorder
      t.string :word
      t.integer :brandid

      t.timestamps
    end
  end
end
