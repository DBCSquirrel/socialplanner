class AddFacebookIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fb_id, :integer
  end
end