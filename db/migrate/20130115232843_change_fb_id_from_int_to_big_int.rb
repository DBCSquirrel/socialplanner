class ChangeFbIdFromIntToBigInt < ActiveRecord::Migration
  def up
    remove_column :fb_id
    add_column :acceptable_invites, :fb_id, :bigint
  end

  def down
    add_column :acceptable_invites, :fb_id, :integer
  end
end
