# encoding: utf-8
class AddTwoColumnsToWxCustomActivities < ActiveRecord::Migration
  def change
    add_column :wx_custom_activities, :join_msg, :string
    add_column :wx_custom_activities, :how_msg, :string
    
    add_index :wx_custom_activities, [:key,:status]
    add_index :wx_activity_logs, [:uid,:activity_id]
  end
end
