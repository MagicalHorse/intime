class AddUpdatedUserToProducts < ActiveRecord::Migration
  def change
    add_column :products, :updateduser_id, :integer
  end
end
