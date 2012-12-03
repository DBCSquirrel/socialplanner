require 'spec_helper'

describe Event do
  let(:event) { build(:event) }
  let(:user) { build(:user) }
  context "#initialization" do

    [:name, :description, :start_datetime, :end_datetime, :location, :headcount_min, :headcount_max, :creator_id].each do |attribute|
      it {should respond_to attribute}
    end
    it { should validate_presence_of(:name) }
    it { should belong_to(:creator) }
    it { should have_many(:event_users).dependent(:destroy) }
    it { should have_many(:guests).through(:event_users) }
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

      it "should have an start date and time" do
        event.start_datetime = ''
        event.save.should be_false
        event.errors.full_messages.should include("Start datetime can't be blank")
      end

      it "should have an end date and time" do
        event.end_datetime = ''
        event.save.should be_false
        event.errors.full_messages.should include("End datetime can't be blank")
      end
    end

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
      event.guests << user1
      event.guests << user2
      event.event_users.find_by_user_id(user1.id).update_attributes(:accepted => true)
      event.accepted_guests.should == [user1]
    end
  end

end

# -event should respond_to event.alias(es)
# -events_invitations
# -events_users
# -event.user.confirmed_at
