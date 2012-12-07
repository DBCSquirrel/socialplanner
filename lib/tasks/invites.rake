desc 'Send invites to people who need them'


=begin
FOR EACH in-progress event
  GET DATA from Facebook (FB API call)
  
  IF event has expired on Facebook
    Expire event in database
    NEXT
  
  Update state of this event's invites, i.e., mark the ones that need marking as accepted/declined/maybe/expired (ActiveRecord call)
  Expire any invites that need expiring (ActiveREcord call)
  
  IF there are no more people to invite (ACtiveREcord call)
    Mark event as completed
    NEXT
  
  IF there are any empty seats at the table, say N (ActiveREcord call)
    Get N pending invites
    Send those N pending invites out via Facebook
    Mark those N pending invites as sent
=end

namespace :invites do
  task :send => :environment do
    Event.tracked.each do |event|
      fb = Koala::Facebook::GraphAPI.new(event.creator.oauth_token)
      #Pull events that are not expired
    
      attending = fb.get_connections(event.fb_id, 'attending')
      attending.each do |invite|
        invite.accept!
      end

      maybe = fb.get_connections(event.fb_id, 'maybe')
      maybe.each do |invite|
        invite.maybe!
      end

      declined = fb.get_connections(event.fb_id, 'declined')
      declined.each do |invite|
        invite.declined!
      end
    
      noreply = fb.get_connections(event.fb_id, 'noreply')
      noreply.each do |invite|
        created_time = AcceptableInvite.find_by_fb_id(invite.id).created_at
        if (Time.now - created_time) > 180 #180 seconds for testing
          invite.expired!
        end
      end      
    
      event.reload
    
      if event.headcount_max > event.acceptable_invites.attending.count
        spots_left = event.headcount_max - event.acceptable_invites.attending.count
      
        spots_left.times do |i|
          i -= 1
          if person = event.acceptable_invites.pending[i]
            fb.put_connections(event.fb_id, "invited", :users => [person.fb_id])
            person.sent!
          end
        end
      end  

    end
  end
end