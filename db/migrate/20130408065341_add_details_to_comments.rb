# encoding: utf-8
class AddDetailsToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.references :user
      t.belongs_to :source,:polymorphic=>true
      t.belongs_to :reply,:class_name=>'Comment'
    end
  end
end
