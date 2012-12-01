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

  def accept
    @event_user = EventUser.find_by_id(params[:id])
    @event_user.accepted = true
    @event_user.save
    flash[:notice] = "Hey, you've accepted! Thanks!"
    redirect_to event_path(@event_user.event_id)
  end

  def destroy
    @event_user = EventUser.find_by_id(params[:id])
    event_id = @event_user.event_id
    @event_user.destroy
    redirect_to event_path(event_id)
  end
end