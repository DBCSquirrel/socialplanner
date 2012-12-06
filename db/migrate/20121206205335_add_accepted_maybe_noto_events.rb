class AddAcceptedMaybeNotoEvents < ActiveRecord::Migration
  def change
    add_column :acceptable_invites, :accepted, :boolean, :default => false
    add_column :acceptable_invites, :maybe, :boolean, :default => false
    add_column :acceptable_invites, :no, :boolean, :default => false
  end
end
