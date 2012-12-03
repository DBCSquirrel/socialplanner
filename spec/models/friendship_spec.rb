require 'spec_helper'

describe Friendship do
  it { should have_db_column(:user_id).of_type(:integer) }
  it { should have_db_column(:friend_id).of_type(:integer) }
  it { should_not have_db_column(:confirmed) }

  it { should validate_presence_of(:user_id) }
  it { should validate_numericality_of(:friend_id) }

  it { should belong_to(:user) }
  it { should belong_to(:friend) }
end