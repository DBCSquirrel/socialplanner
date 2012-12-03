require 'spec_helper'

describe UsersController do

  let(:user) { build(:user) }

  describe "#create" do

    context "with valid parameters" do
      it "should successfully add user to the database" do
        user.save!
        response.should be_success
      end
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
  end

  describe '#pending_events' do
  end

  describe '#attending_events' do
  end

  describe '#destroy' do

    it "should remove a user record from the database" do
      user.save!
      expect do
        delete :destroy, { :id => user.id }
      end.to change{User.count}.by(-1)
    end
  end

end