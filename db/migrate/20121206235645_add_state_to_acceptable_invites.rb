class AddStateToAcceptableInvites < ActiveRecord::Migration
  def change
    add_column :acceptable_invites, :state, :string, :null => false, :default => 'pending'
    add_index :acceptable_invites, :state
  end
end
