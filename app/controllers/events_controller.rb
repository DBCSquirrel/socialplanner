class EventsController < ApplicationController
  def index
    @events = Event.all
  end

<<<<<<< HEAD
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
    @event = Event.find_by_id(params[:id])
  end

  def update
    @event = Event.find_by_id(params[:id])
    @event.update_attributes(params[:event])
    if @event.save
      redirect_to event_path
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find_by_id(params[:id])
    if @event.destroy
      redirect_to events_path
    else
      render(:text => 'Sorry, your event was not successfully deleted. Please try again.')
    end
  end
=======
	def index
    @events = current_user.created_events
	end
>>>>>>> add functional duplicate-lane and remove-lane js functionality

end