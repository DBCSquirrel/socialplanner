class AddNameToAcceptableInvites < ActiveRecord::Migration
  def change
    add_column :acceptable_invites, :name, :string
  end
end
