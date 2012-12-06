require 'net/http'
class AcceptableInvitesController < ApplicationController
  def new
    @acceptable_invites = Event.find(params[:event_id]).acceptable_invites
  end

  def create
    @event = Event.find(params[:event_id])
    @acceptable_invites = params[:acceptable_invites]
    @acceptable_invites.each do |fb_id|
      @event.acceptable_invites << AcceptableInvite.create(:fb_id => fb_id.to_i, :invited => false)
    end
    update
    #call background process to start/run batch for first time
  end
  
  def update
    event = Event.find(params[:id])
    event.acceptable_invites[]
    url = "http://graph.facebook.com/#{}"
    url = URI.parse(url)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) do |http|
                      http.request(req)
                    end
  end
end