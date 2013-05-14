class AddUpdateTypeToVersion < ActiveRecord::Migration
  def change
      change_table :versions do |t|
      t.integer :updatetype
    end
  end
end
