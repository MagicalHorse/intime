# encoding: utf-8
class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :user_requests do |t|
      t.string :utoken
      t.string :msg
      t.string :lastaction
      t.integer :lastpage

      t.timestamps
    end
  end
end
