# encoding: utf-8
class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.integer :status
      t.integer :sortorder

      t.timestamps
    end
  end
end
