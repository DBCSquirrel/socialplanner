class AddAcceptedToEventUsers < ActiveRecord::Migration
  def change
    add_column :event_users, :accepted, :boolean, :default => false
  end
end
