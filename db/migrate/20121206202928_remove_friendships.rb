class RemoveFriendships < ActiveRecord::Migration
  def up
    drop_table :friendships
  end

  def down
    create_table "friendships", :force => true do |t|
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer  "user_id"
      t.integer  "friend_id"
    end
  end
end
