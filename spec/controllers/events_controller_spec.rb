require 'spec_helper'

describe EventsController do

  let(:event) { build(:event) }

  let(:valid_attributes) do
    build(:event).attributes.delete_if { |k,v| k == 'id' || k == 'created_at' || k == 'updated_at' }
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
      event # create an event in the database
      get :index # send request to index action of controller
      assigns(:events).should_not be_nil
    end

  end

  describe '#create' do

    context "with valid parameters" do
      it "saves a new event to the database" do

        expect do
          post :create, { :event => valid_attributes }
        end.to change{ Event.count }.by(1)
      end

      it "automatically includes the event creator as accepting their own invitation" do
        user1 = create(:user)
        event1 = user1.created_events.create(valid_attributes)
        event1.accepted_guests.should include(user1)
      end

      it "redirects to the index page" do
        post(:create, { :event => valid_attributes}).should redirect_to events_path
      end
    end

    context "with invalid parameters" do

      it "does not save a new event to the database" do
        invalid_attributes = valid_attributes
        invalid_attributes[:name] = ""
        expect do
          post :create, { :event => invalid_attributes }
        end.to change{ Event.count }.by(0)
      end

      it "renders the #new page" do
        invalid_attributes = valid_attributes
        invalid_attributes[:name] = ""
        post(:create, { :event => invalid_attributes}).should render_template('new')
      end
    end
  end

  describe "#edit" do
    before do
      @event = Event.create(valid_attributes)
    end

    it "renders the edit form" do
      get(:edit, { :id => @event.id}).should render_template('edit')
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
      expect do
        delete :destroy, { :id => event.id }
      end.to change{ Event.count }.by(-1)
    end
  end
end