class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :events, :description, :string
    add_column :events, :admin_id, :integer
    add_column :events, :start_datetime, :datetime
    add_column :events, :end_datetime, :datetime
    add_column :events, :location, :string
    add_column :events, :headcount_min, :integer, :default => 1
    add_column :events, :headcount_max, :integer, :default => 0
  end
end