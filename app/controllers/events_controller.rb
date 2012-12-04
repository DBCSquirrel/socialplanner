class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      @event_user = @event.event_users.create(:user_id => @event.creator_id, :accepted => true)
      redirect_to events_path
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find params[:id]
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find params[:id]
    @event.update_attributes params[:event]
    if @event.save
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find params[:id]
    if @event.destroy
      redirect_to events_path
    else
      render(:text => 'Sorry, your event was not successfully deleted. Please try again.')
    end
  end

end