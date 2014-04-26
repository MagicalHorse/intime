# encoding: utf-8
class CreateWxReplyMsgs < ActiveRecord::Migration
  def change
    create_table :wx_reply_msgs do |t|
      t.string :rkey
      t.string :rmsg
      t.integer :status

      t.timestamps
    end
  end
end
