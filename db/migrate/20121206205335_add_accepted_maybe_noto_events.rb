class AddAcceptedMaybeNotoEvents < ActiveRecord::Migration
  def change
    add_column :events, :accepted, :boolean, :default => false
    add_column :events, :maybe, :boolean, :default => false
    add_column :events, :no, :boolean, :default => false
  end
end
