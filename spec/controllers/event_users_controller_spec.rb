require 'spec_helper'

describe EventUsersController do
   let(:event_user) { build(:event_user) }
   let(:valid_attributes) { build(:event_user).attributes.delete_if { |k,v| k == 'id' || k == 'created_at' || k == 'updated_at' }}

   describe '#new' do
     it "sets up a form for event_user" do
       get :new
       assigns(:event_user).should_not be_nil
       assigns(:event_user).should be_an_instance_of(EventUser)
     end

   end

   describe '#create' do
     it "adds an event_user record to the database" do
       expect do
         post :create, { :event_user => valid_attributes }
       end.to change{ EventUser.count }.by(1)
     end
   end

   describe '#accept' do
     it "sets the user to accept the invite" do
       event_user.save!
       expect do
         put :accept, { :id => event_user.id }
         event_user.reload
       end.to change{ event_user.accepted }.from(false).to(true)
     end
   end

   describe '#destroy' do
     it "removes the event_user from the database" do
       event_user.save!
       expect do
         delete :destroy, { :id => event_user.id }
       end.to change{EventUser.count}.by(-1)
     end
   end
end