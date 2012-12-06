class CreateAcceptableInvites < ActiveRecord::Migration
  def change
    create_table :acceptable_invites do |t|
      t.integer :event_id, :fb_id
      t.boolean :invited, :default => false
      t.timestamps
    end

    add_index :acceptable_invites, [:event_id, :fb_id], :unique => true
  end
end
