# encoding: utf-8
class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :domain
      t.string :name
      t.integer :sortorder
      t.integer :status
      t.integer :width
      t.integer :height
      t.integer :length
      t.integer :type
      t.references :source, :polymorphic=>true
      t.timestamps
    end
  end
end
