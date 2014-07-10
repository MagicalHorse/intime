class RemoveColumnIsPublicDefaultForCombos < ActiveRecord::Migration
  def up
    change_column_default :combos, :is_public, nil
  end

  def down
    change_column_default :combos, :is_public, false
  end
end
