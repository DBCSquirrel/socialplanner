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
      
      FOREACH ATTENDING
        ATTENDEE.accept!
      END FOREACH
      
      FOREACH MAYBE
        MAYBE.maybe!
      END FOREACH
      
      FOREACH DECLINED
        DECLINED.declined!
      END FOREACH
      
      FOREACH NOREPLY
        IF ITS BEEN TOO LONG
          NOREPLY.expired!
        END
        
      END FOREACH
      
      event.acceptable_invites.sent => returns list of all users who have received invite and not responded
      of these, we expire some of those users
      
      based on need, send out more invites for event
      
      
      

      fb.put_connections(event.fb_id, "invited", :users => event.invite_users.map(&:fb_id))
      event.invite_users.each do |item|
        item.invite! #recording invitation on database
      end
    end
  end
end