require 'spec_helper'

describe Event do
  let(:event) { build(:event) }
  let(:user) { build(:user) }
  context "#initialization" do
    it { should belong_to(:creator) }
    it { should have_many(:event_users).dependent(:destroy) }
    it { should have_many(:guests).through(:event_users) }
    it { should have_many(:invited_guests).through(:event_users) }
    it { should have_many(:accepted_guests).through(:event_users) }

    it { should have_many(:comments) }
    it { should have_db_column(:private).of_type(:boolean).with_options(:default => false) }

    context "validations" do
      it "should have a name" do
        event.name = ""
        event.save.should be_false
        event.errors.full_messages.should include("Name can't be blank")
      end

      it "should have an creator" do
        event.creator_id = nil
        event.save.should be_false
        event.errors.full_messages.should include("Creator can't be blank")
      end

    end
  end

  context "#valid?" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:creator) }
    it { should validate_presence_of(:start_datetime) }
    it { should validate_presence_of(:end_datetime) }
    it { should validate_numericality_of(:headcount_min).only_integer }
    it { should validate_numericality_of(:headcount_max).only_integer }
  end


  context "adding guests to event" do
    it "should initially have an association with guests" do
      event.should respond_to(:guests)
    end
  end

  it "should have a creator" do
    event.creator = user
    event.creator.should eq( user )
  end

  context "is activated" do #Activated events are those that have met their minimum headcount and thus are going to happen.
    it "by default, will be activated" do
      event.save
      event.active?.should be_true
    end

    it "when minimum headcount is met" do
      event.headcount_min = 5
      event.save
      4.times do |i|
        new_user = create(:user)
        new_user.event_users.create(:event_id => event.id).accept
        event.reload
        event.active?.should be_false
      end
      new_user = create(:user)
      new_user.event_users.create(:event_id => event.id).accept
      event.reload
      event.active?.should be_true
    end

  end

  describe '#accepted_guests' do
    it "returns a list of guests who have accepted the invitation" do
      event.save!

      user1 = create(:user)
      user2 = create(:user)

      event.accepted_guests  << user1
      event.invited_guests << user2

      event.accepted_guests.should include user1
      event.accepted_guests.should_not include user2
    end
  end

end

# -event should respond_to event.alias(es)
# -events_invitations
# -events_users
# -event.user.confirmed_at
