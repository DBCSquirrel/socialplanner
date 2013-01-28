require 'spec_helper'

describe Event do
  let(:event) { build(:event) }
  let(:user) { build(:user) }

  it { should belong_to(:creator) }
  it { should have_db_column(:private).of_type(:boolean).with_options(:default => false) }

  context "#valid?" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:creator) }
    it { should validate_presence_of(:start_datetime) }
    it { should validate_presence_of(:end_datetime) }
    it { should validate_numericality_of(:headcount).only_integer }
  end
end

# -event should respond_to event.alias(es)
# -events_invitations
# -events_users
# -event.user.confirmed_at
