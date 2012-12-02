require 'spec_helper'

describe EventUser do
  let(:event_user) { build(:event_user) }
  describe '#initialization' do
    it "should have a user id" do
      event_user.user_id = nil
      event_user.save.should be_false
      event_user.errors.full_messages.should include("User can't be blank")
    end

    it "should have a event id" do
      event_user.event_id = nil
      event_user.save.should be_false
      event_user.errors.full_messages.should include("Event can't be blank")
    end

    it "when initialized, should have not yet accepted the invitation" do
      event_user.save!
      event_user.accepted.should eq(false)
    end

    describe 'database constraints' do
      it 'should only have one pairing of {event_id, user_id}'
    end
  end
end
