class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :status
      t.string :textmsg

      t.timestamps
    end
  end
end
