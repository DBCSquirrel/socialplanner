class EventsController < ApplicationController
  def index
    @events = current_user.created_events
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.new(params[:event])

    if @event.valid?
      callback = current_user.facebook.put_object('me', 'events', @event.to_facebook_params)

      @event.fb_id = callback["id"]
      @event.save

      render 'update'
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])

    if @event.acceptable_invites.any?
      render 'details' # table of friends
    else
      render 'empty'
    end
  end

  def update
    @event = Event.find(params[:id])

    @event.attributes = params[:event]
# ---- modified code from rake invites:send, need to process first batch
    fb = Koala::Facebook::GraphAPI.new(@event.creator.oauth_token)
    if @event.headcount > @event.acceptable_invites.attending.count
      spots_left = @event.headcount - @event.acceptable_invites.attending.count

      spots_left.times do |i|
        i -= 1
        if person = @event.acceptable_invites.pending[i]
          fb.put_connections(@event.fb_id, "invited", :users => person.fb_id)
          person.noreply!
        end
      end
    end
#----------------
    if @event.save
      render 'details'
    else
      redirect_to @event
    end
  end

  def destroy
    @event = Event.find params[:id]
    fb = Koala::Facebook::GraphAPI.new(@event.creator.oauth_token)
    callback = fb.rest_call("events.cancel", { eid: @event.fb_id, cancel_message: "", callback: "" })    
    if callback && @event.destroy
      redirect_to events_path
    else
      render(:text => 'Sorry, your event was not successfully deleted. Please try again.')
    end
  end

end
