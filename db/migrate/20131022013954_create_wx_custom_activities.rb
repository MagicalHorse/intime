# encoding: utf-8
class CreateWxCustomActivities < ActiveRecord::Migration
  def change
    create_table :wx_custom_activities do |t|
      t.string :key
      t.integer :status
      t.datetime :valid_from
      t.datetime :valid_end
      t.string :succsss_msg

      t.timestamps
    end
  end
end
