class EliminateRedundantFieldsFromAcceptableInvites < ActiveRecord::Migration
  def change
    remove_column :acceptable_invites, :invited
    remove_column :acceptable_invites, :accepted
    remove_column :acceptable_invites, :maybe
    remove_column :acceptable_invites, :no    
  end
end
