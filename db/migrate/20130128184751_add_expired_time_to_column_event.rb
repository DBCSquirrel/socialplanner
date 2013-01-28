class AddExpiredTimeToColumnEvent < ActiveRecord::Migration
  def change
    add_column :events, :expired_time, :integer
  end
end
