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
    end

    context "with invalid parameters" do
      it "should fail to add user to the database" do
        user.uid = nil
        expect { user.save }.to_not change(User, :count)
      end
    end
  end

  describe '#destroy' do
    it "removes a user record from the database" do
      user.save!

      expect {
        delete :destroy, { :id => user.id }
      }.to change(User, :count).by(-1)
    end
  end
end
