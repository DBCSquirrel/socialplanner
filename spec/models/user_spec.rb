require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  let(:event) { user.created_events.build }

  it { should have_many(:event_users).dependent(:destroy) }
  it { should have_many(:guest_invitations).through(:event_users) }
  it { should have_many(:created_events).dependent(:destroy) }

  context "initialization" do
    it "should have a name" do
      user.name = ""
      user.save.should be_false
      user.errors.full_messages.should include("Name can't be blank")
    end

    it "has an oauth_token" do
      user.oauth_token = ""
      user.save.should be_false
      user.errors.full_messages.should include("Oauth token can't be blank")
    end

    xit "should have a properly formatted oauth_token" do
    end

    it "has a facebook uid" do
      user.uid = ""
      user.save.should be_false
      user.errors.full_messages.should include("Uid can't be blank")
    end

    it "should have a numerical facebook uid" do
      user.uid = "asdfasdfasd"
      user.save.should be_false
      user.errors.full_messages.should include("Uid is not a number")
    end

    it "has a unique facebook uid" do
      user.uid = "555"
      user2 = create(:user, :uid => "555")
      user.save.should be_false
      user.errors.full_messages.should include("Uid has already been taken")
    end

    it "has a provider called 'facebook'" do
      user.provider = 'facebookish'
      user.save.should be_false
      user.errors.full_messages.should include("Provider is invalid")
    end

  end

  context "invitation message" do
    xit "receives message if invited to event" do
    end
  end

  describe '#guest_invitations' do
    it "returns a list of events the user has been invited to" do
      user.save!
      event = create(:event)
      event.guests << user
      user.guest_invitations.should == [event]
    end

    it "by default, guest has not accepted event invitation" do
      user.save!
      event = create(:event)
      event.guests << user
      not_yet_accepted = event.guests.joins(:event_users).where("event_users.accepted" => false)
      not_yet_accepted.last.should eq(user)
    end

  end

  describe ".attending" do
    it "returns a list of events that user has accepted invitations to" do
      user.save!
      event = create(:event)
      event.guests << user
      event.event_users.find_by_user_id(user.id).update_attributes(:accepted => true)
      user.attending_events.last.should eq(event)
    end
  end
end