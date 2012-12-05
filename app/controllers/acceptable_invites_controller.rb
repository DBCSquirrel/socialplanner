class AcceptableInvitesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @acceptable_invites = params[:acceptable_invites]
  end

  def create
    @event = Event.find(params[:event_id])
    @acceptable_invites = params[:acceptable_invites]
    @acceptable_invites.each do |fb_id|
      @event.acceptable_invites << AcceptableInvite.create(:fb_id => fb_id.to_i, :invited => false)
    end
  end

end