# encoding: utf-8
class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :no
      t.string :level
      t.integer :point
      t.datetime :validatedate
      t.string :utoken
      t.boolean :isbinded
      
      t.timestamps
    end
  end
end
