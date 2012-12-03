require 'spec_helper'

describe UsersController do

  let(:user) { build(:user) }
  let(:event) { build(:event) }

  describe "#create" do

    context "with valid parameters" do
      it "should successfully add user to the database" do
        user.save!
        response.should be_success
      end

      it "should establish friendships with all FB friends on squirrly"
        #setup friendship with first user
        #confirmed value should be false
        #friend joins squirrly
        #confirmed value should now be true
    end


    context "with invalid parameters" do
      it "should fail to add user to the database" do
        user.uid = nil
        expect do
          user.save
        end.to_not change{User.count}
      end
    end

  end

  describe '#invitations' do
    it "has tests for user.invitations"
  end

  describe '#pending_events' do
    it "has tests for user.pending_events"
  end

  describe '#attending_events' do
    it "has tests for user.attending_events"
  end

  describe '#destroy' do

    it "should remove a user record from the database" do
      user.save!
      expect do
        delete :destroy, { :id => user.id }
      end.to change{User.count}.by(-1)
    end

    it "should remove all dependencies of friendships" do
      user.save!
      user.friendships.create(:friend_id => 12)
      user.destroy
      Friendship.count.should eq(0)
    end
  end
end