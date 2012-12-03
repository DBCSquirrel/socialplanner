class EventUsersController < ApplicationController

  def new
    @event_user = EventUser.new
    render :partial => 'new'
  end

  def create
    @event_user = EventUser.new(params[:event_user])
    @event_user.save
    redirect_to root_path
  end

  def update
    @event_user = EventUser.find_by_id(params[:id])
    if @event_user.accept
      flash[:notice] = "Hey, you've accepted! Thanks!"
    else
      flash[:warning] = "Sorry, but this event is full."
    end
    redirect_to event_path(@event_user.event_id)
  end

  def destroy
    @event_user = EventUser.find_by_id(params[:id])
    event_id = @event_user.event_id
    @event_user.destroy
    redirect_to event_path(event_id)
  end
end