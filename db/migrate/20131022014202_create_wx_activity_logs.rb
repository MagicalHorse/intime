# encoding: utf-8
class CreateWxActivityLogs < ActiveRecord::Migration
  def change
    create_table :wx_activity_logs do |t|
      t.integer :activity_id
      t.string :uid
      t.string :vip_card

      t.timestamps
    end
  end
end
