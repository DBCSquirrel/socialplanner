require 'spec_helper'

describe EventsController do

  let(:event) { build(:event) }

  let(:valid_attributes) do
    FactoryGirl.build(:event).attributes.delete_if { |k,v| k == 'id' || k == 'created_at' || k == 'updated_at' }
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
    it "provides a @event variable"

  end

  describe "#update" do

    context "saves"

  end

  describe "deleting existing event" do

  end
end