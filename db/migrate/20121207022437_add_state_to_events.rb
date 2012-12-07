class AddStateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :state, :string, :null => false, :default => 'in_progress'
    add_index :events, :state
  end
end
