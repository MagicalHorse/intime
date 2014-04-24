# encoding: utf-8
class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.integer :no
      t.string :versionno
      t.integer :status
      t.string :desc
      t.string :downloadurl

      t.timestamps
    end
  end
end
