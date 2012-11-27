class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :events, :description, :string
    add_column :events, :admin_id, :integer
    add_column :events, :start_datetime, :datetime
    add_column :events, :end_datetime, :datetime
    add_column :events, :location, :string
    add_column :events, :headcount_required, :boolean
    add_column :events, :headcount, :integer

  end
end

# :name, :description, :admin, :start_datetime, :end_datetime, :location, :headcount_required, :headcount, :attendees_list