require 'spec_helper'

describe Event do
  before :each do
    @test = Event.new
  end

  context "#initialization" do

    [:name, :description, :admin_id, :start_datetime, :end_datetime, :location, :headcount_required, :headcount, :attendees_list].each do |attribute|
      it {should respond_to attribute}
    end

    it "should be an instance of Event" do
      @test.should be_an_instance_of(Event)
    end

    it "should have a has_many_and_belongs_to relationship with users"

    context "validations"

  end

end