require 'spec_helper'

describe Event do
  let(:event) { build(:event) }
  context "#initialization" do

    [:name, :description, :admin_id, :start_datetime, :end_datetime, :location, :headcount_required, :headcount].each do |attribute|
      it {should respond_to attribute}
    end

    it "should have a has_many_and_belongs_to relationship with users"

    context "validations" do
      it "should have a name" do
        event.name = ""
        event.save.should be_false
        event.errors.full_messages.should include("Name can't be blank")
      end

      it "should have a description" do
        event.description = ""
        event.save.should be_false
        event.errors.full_messages.should include("Description can't be blank")
      end

      it "should have an admin_id" do
        event.admin_id = nil
        event.save.should be_false
        event.errors.full_messages.should include("Admin can't be blank")
      end

      it "should have an start date and time" do
        event.start_datetime = ''
        event.save.should be_false
        event.errors.full_messages.should include("Start datetime can't be blank")
      end

    end

  end

end