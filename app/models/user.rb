class User < ActiveRecord::Base
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

  validates :name, :presence => true
  validates :oauth_token, :presence => true
  validates :uid, :presence => true, :uniqueness => true, :numericality => true
  validates :provider, :format => { :with => /^facebook$/}

  has_many :created_events, :class_name => "Event", :foreign_key => "creator_id", :dependent => :destroy

  has_many :event_users, :dependent => :destroy
  has_many :guest_invitations, :through => :event_users, :source => :event

  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships

  def invitations
    guest_invitations.joins(:event_users).where("event_users.accepted" => false)
  end

  def pending_events
    events = self.guest_invitations.joins(:event_users).where("event_users.accepted" => true)
    pending = []
    events.each do |event|
      if event.headcount_min == nil
        #do nothing
      elsif event.headcount_min > event.headcount
        pending << event
      end
    end
    pending
  end

  def attending_events
    events = self.guest_invitations.joins(:event_users).where("event_users.accepted" => true)
    attending = []
    events.each do |event|
      if event.headcount_min == nil
        attending << event
      elsif event.headcount_min <= event.headcount
        attending << event
      end
    end
    attending
  end


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def facebook
    logger.info "got into facebook method"
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def create_friendships
    facebook
    friends_list = @facebook.get_connections("me", "friends")
    friends_list.each do |fb_friend|
      if squirrly_friend = User.find_by_uid(fb_friend["id"])
        Friendship.create(:user_id => self.id, :friend_id => squirrly_friend.id)
        Friendship.create(:user_id => squirrly_friend.id, :friend_id => self.id)
      end
    end
  end
end