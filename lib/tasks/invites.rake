desc 'Send invites to people who need them'
task :send_invites => :environment do
  #go through all users on squirrly
  #check all of events 
  
  #logic for check which events need to be tracked,
  #if event is now full, then remove event from Event.tracking list
  
  # events_tracking = Event.tracking
  # events_tracking.each do |event|
    # creator = User.find(event.creator_id)
    creator = User.find(5)
    graph = Koala::Facebook::GraphAPI.new(creator.oauth_token)
    # graph.get_connections(event.fb_id, 'attending')
    callback = graph.get_connections('449237031807443', 'attending')
    puts callback.inspect
  # end

  #do facebook api call, grab events based on event_id, 
  # test event id is 449237031807443
  
end