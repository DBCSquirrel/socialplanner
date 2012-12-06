class AddFbIdToEventUsers < ActiveRecord::Migration
  def up
    add_column :event_users, :fb_id, :integer
    remove_column :event_users, :user_id
  end

  def down
    remove_column :event_users, :fb_id
    add_column :event_users, :user_id, :integer
  end
end
