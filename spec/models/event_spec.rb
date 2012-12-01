require 'spec_helper'

describe Event do
  let(:event) { build(:event) }
  let(:user) { build(:user) }
  context "#initialization" do

    [:name, :description, :start_datetime, :end_datetime, :location, :headcount_min, :headcount_max, :creator_id].each do |attribute|
      it {should respond_to attribute}
    end
    it { should validate_presence_of(:name) }

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
  context "adding invited_guests to event" do
    it "should initially have an association with invited_guests" do
      event.should respond_to(:invited_guests)
    end
  end

  it "should have a creator" do
    event.creator = user
    event.creator.should eq( user )
  end

  context "event is activated" do #Activated events are those that have met their minimum headcount and thus are going to happen.
    xit "by default, will be activated" do
      #event.headcount_max.should eq(0)
      event.headcount_max == attendees_list.headcount
    end

    xit "should be activated when minimum headcount is met" do

    end

  end

  context "user accepts invite to event" do
    xit "should add user to attendees list" do
      # check for user_id in db?
    end
  end

  describe ".attending_guests" do
    it "returns a list of guests marked as attending" do
      event.save!
      user1 = create(:user)
      user2 = create(:user)
      event.invited_guests << user1
      event.invited_guests << user2
      event.event_users.find_by_user_id(user1.id).update_attributes(:accepted => true)
      event.attending_guests.should == [user1]
    end
  end

end

# -event should respond_to event.alias(es)
# -events_invitations
# -events_users
# -event.user.confirmed_at
