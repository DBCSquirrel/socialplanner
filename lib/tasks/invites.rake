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
      puts 'beginning task'
      Event.tracked.each do |event|
      fb = Koala::Facebook::GraphAPI.new(event.creator.oauth_token)
        puts "checking on event '#{event.name}"

      attending = fb.get_connections(event.fb_id, 'attending')
      puts attending.inspect
      attending.each do |invite|
        acceptable_invite = event.acceptable_invites.find_by_fb_id(invite["id"])
        if acceptable_invite
          acceptable_invite.attending!
          puts "#{acceptable_invite.name} now attending"
        end
      end

      event.reload

      maybe = fb.get_connections(event.fb_id, 'maybe')
      maybe.each do |invite|
        acceptable_invite = event.acceptable_invites.find_by_fb_id(invite["id"])
        if acceptable_invite
          callback = fb.graph_call("/#{acceptable_invite.event.fb_id}/invited/#{acceptable_invite.fb_id}", {}, "DELETE")
          acceptable_invite.maybe! if callback
          puts "#{acceptable_invite.name} said maybe -- removed"
        end
      end

      event.reload

      declined = fb.get_connections(event.fb_id, 'declined')
      declined.each do |invite|
        acceptable_invite = event.acceptable_invites.find_by_fb_id(invite["id"])
        if acceptable_invite
          callback = fb.graph_call("/#{acceptable_invite.event.fb_id}/invited/#{acceptable_invite.fb_id}", {}, "DELETE")          
          acceptable_invite.declined! if callback
          puts "#{acceptable_invite.name} declined -- removed"
        end
      end
      
      event.reload
      
      noreply = fb.get_connections(event.fb_id, 'noreply')
      noreply.each do |invite|
        acceptable_invite = event.acceptable_invites.find_by_fb_id(invite["id"])
        if acceptable_invite
          created_time = AcceptableInvite.find_by_fb_id(invite["id"]).created_at
          if (Time.now - created_time) > event.expired_time
            callback = fb.graph_call("/#{acceptable_invite.event.fb_id}/invited/#{acceptable_invite.fb_id}", {}, "DELETE")
            acceptable_invite.expired! if callback
            puts "#{acceptable_invite.name} took to long to reply to event -- removed"
          end
        end
      end

      event.reload

      if event.headcount > event.acceptable_invites.attending.count
        spots_left = event.headcount - event.acceptable_invites.attending.count

        spots_left.times do |i|
          i -= 1
          if person = event.acceptable_invites.pending[i]
            callback = fb.put_connections(event.fb_id, "invited", :users => person.fb_id)
            person.noreply! if callback
            puts "#{acceptable_invite.name} is now invited to the event"
          end
        end
      end

     end
  end
end