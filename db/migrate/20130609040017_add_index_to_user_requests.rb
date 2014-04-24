# encoding: utf-8
class AddIndexToUserRequests < ActiveRecord::Migration
  def change
    add_index :user_requests, [:utoken]
  end
end
