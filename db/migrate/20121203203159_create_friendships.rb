class CreateFriendships < ActiveRecord::Migration
  def up
    create_table :friendships do |t|

      t.timestamps
    end
  end
end