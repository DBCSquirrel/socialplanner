require 'spec_helper'

describe Event do
  let(:event) { build(:event) }
  context "#initialization" do

    [:name, :description, :admin_id, :start_datetime, :end_datetime, :location, :headcount_min, :headcount_max].each do |attribute|
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

      it "should have an end date and time" do
        event.end_datetime = ''
        event.save.should be_false
        event.errors.full_messages.should include("End datetime can't be blank")
      end

      it "should have a location" do
        event.location = ''
        event.save.should be_false
        event.errors.full_messages.should include("Location can't be blank")
      end

      it "should have a headcount min" do
        event.headcount_min = nil
        event.save.should be_false
        event.errors.full_messages.should include("Headcount min can't be blank")
      end

      it "should have a headcount max" do
        event.headcount_max = nil
        event.save.should be_false
        event.errors.full_messages.should include("Headcount max can't be blank")
      end

  end

  context "event is activated" do #Activated events are those that have met their minimum headcount and thus are going to happen.
    it "by default, will be activated" do
      #event.headcount_max.should eq(0)
      event.headcount_max == attendees_list.headcount
    end

    xit "should be activated when minimum headcount is met" do
      event.headcount_min = 6
    end

  end

  context "event is full"
    it "by default, should have no max" do
      event.headcount_max.should eq(0)
    end
  end
end