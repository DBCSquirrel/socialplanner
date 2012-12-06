class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.new(params[:event])

    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find params[:id]
  end

 def show
    @event = Event.find(params[:id])
    if @event.acceptable_invites.any?
      render 'show' # event status
    else
      render 'details' # table of friends
    end
  end

  def update
    @event = Event.find params[:id]

    @event.update_attributes(params[:event])

    if @event.save
      render :json => @event.acceptable_invites
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

