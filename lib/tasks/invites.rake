desc 'Send invites to people who need them'

namespace :invites do
  task :send => :environment do
    Event.tracked.each do |event|
      fb = Koala::Facebook::GraphAPI.new(event.creator.oauth_token)
      invite_users = event.acceptable_invites.pending_batch
      fb.put_connections(event.fb_id, "invited", :users => event.invite_users.map(&:fb_id))
      event.invite_users.each do |item|
        item.invite
      end
    end
  end
end