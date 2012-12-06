require 'spec_helper'

describe EventsController do

  let(:event) { build(:event) }

  let(:valid_attributes) do
    FactoryGirl.attributes_for(:event)
  end

  let(:current_user) { create(:user) }

  before(:each) do
    controller.stub(:current_user).and_return current_user
    FakeWeb.register_uri :post,
                         "https://graph.facebook.com/me/events",
                         :body => '{"data":{"id":"12345"}}'
  end

  describe '#new' do
    it "@event passed along for view" do
      get :new
      assigns(:event).should_not be_nil
      assigns(:event).should be_an_instance_of(Event)
    end
  end

  describe '#index' do

    it "assigns to @events" do
      event
      get :index # send request to index action of controller
      assigns(:events).should_not be_nil
    end
  end

  describe '#create' do

    context "with valid parameters" do
      it "saves a new event to the database" do
        expect {
          post :create, { :event => valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it "redirects to the event show page" do
        post(:create, { :event => valid_attributes}).should redirect_to event_path(Event.last)
      end
    end

    context "with invalid parameters" do

      it "does not save a new event to the database" do
        invalid_attributes = valid_attributes
        invalid_attributes[:name] = ""
        expect {
          post :create, { :event => invalid_attributes }
        }.to_not change(Event, :count)
      end

      it "renders the #new page" do
        invalid_attributes = valid_attributes
        invalid_attributes[:name] = ""
        post(:create, { :event => invalid_attributes}).should render_template('new')
      end
    end
  end

  describe "#edit" do
    it "renders the edit form" do
      event.save!

      get(:edit, { :id => event.id}).should render_template('edit')
    end
  end

  describe "#update" do
    #need to have event established on test database FIRST before attempting to update
    # before do
    #   @event = Event.create(valid_attributes)
    # end

    context "with valid parameters"

      it "saves the updated event to the database" do
        event.save!
        put(:update, { :id => event.id, :event => { :location => "San Francisco" } })

        # event.location.should eq "San Francisco"
      end

      it "redirects to event_path after saving" do
        event.save!
        put(:update, { :id => event.id, :event => { :location => "San Francisco" } }).should redirect_to event_path
      end

    context "with invalid parameters"
      it "renders the edit form" do
        event.save!
        put(:update, { :id => event.id, :event => { :name => "" } }).should render_template('edit')
      end
  end

  describe "deleting existing event" do

    it "should remove a record from the database" do
      event.save!

      expect {
        delete :destroy, { :id => event.id }
      }.to change(Event, :count).by(-1)
    end
  end
end
