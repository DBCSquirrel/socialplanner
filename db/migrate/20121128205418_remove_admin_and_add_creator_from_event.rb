class RemoveAdminAndAddCreatorFromEvent < ActiveRecord::Migration
  def up
    add_column :events, :creator_id, :integer
    remove_column :events, :admin_id
  end

  def down
    add_column :events, :admin_id, :integer
    remove_column :events, :creator_id
  end
end
