# encoding: utf-8
class ChangeKeysToAuthKey < ActiveRecord::Migration
  def up
    rename_table 'keys','auth_keys'
  end

  def down
    rename_table 'auth_keys','keys'
  end
end
