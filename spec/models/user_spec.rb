require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  let(:event) { user.created_events.build }

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
      user2 = create(:user)
      user.save.should be_false
      user.errors.full_messages.should include("Uid has already been taken")
    end

    it "has a provider called 'facebook'" do
      user.provider = 'facebookish'
      user.save.should be_false
      user.errors.full_messages.should include("Provider is invalid")
    end

    it "has many events" do
      user.created_events.should eq( [event] )
    end
  end

  context "create invite" do
    xit "recieves an invitation if invited to event" do
    end

    xit "gets updated to attendee if accepts invitation to event" do
    end
  end

  context "received invites" do
    it "user is associated with respective events" do
      user.should respond_to(:guest_invitations)
    end
  end
end