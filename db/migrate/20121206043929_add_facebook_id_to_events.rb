class AddFacebookIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fb_id, :integer, :null => false, :default => 0
  end
end
