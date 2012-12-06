class RemoveEventUsers < ActiveRecord::Migration
  def up
    drop_table :event_users
  end

  def down
    create_table "event_users", :force => true do |t|
      t.integer  "event_id"
      t.datetime "created_at",                    :null => false
      t.datetime "updated_at",                    :null => false
      t.boolean  "accepted",   :default => false
      t.integer  "fb_id"
    end
  end
end
