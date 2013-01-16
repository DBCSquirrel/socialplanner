class ChangeFbIdFromIntToBigInt < ActiveRecord::Migration
  def up
    remove_column :acceptable_invites, :fb_id
    add_column :acceptable_invites, :fb_id, :bigint
  end

  def down
    remove_column :acceptable_invites, :fb_id, :bigint
    add_column :acceptable_invites, :fb_id, :integer
  end
end
