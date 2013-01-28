class DropHeadcountMinRenameHeadcountMaxToHeadcountFromAcceptableInvites < ActiveRecord::Migration
  def up
    remove_column :events, :headcount_min
    rename_column :events, :headcount_max, :headcount
  end

  def down
    add_column :events, :headcount_min, :integer
    rename_column :events, :headcount, :headcount_max
  end
end
