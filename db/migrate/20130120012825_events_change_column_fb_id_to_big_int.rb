class EventsChangeColumnFbIdToBigInt < ActiveRecord::Migration
  def up
    change_column :events, :fb_id, :bigint
  end

  def down
    change_column :events, :fb_int, :int
  end
end
