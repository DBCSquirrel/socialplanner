class Event < ActiveRecord::Base

  attr_accessible :id, :created_at, :updated_at, :name, :description,
                  :creator_id, :start_datetime, :end_datetime, :location,
                  :headcount, :private, :invitees_info,
                  :fb_id, :invited, :expired_time

  validates :name, :presence => true
  validates :creator, :presence => true

  validates :start_datetime, :presence => true
  validates_datetime :end_datetime, :after => :start_datetime, :after_message => "must be set a time after event start time"
  
  validates :end_datetime, :presence => true
  validates_datetime :start_datetime, :after => lambda { 1.hour.from_now }, :after_message => "must be at least an hour from now"

  validates :headcount, :numericality => { :greater_than => 0, :only_integer => true }
  validates :expired_time, :presence => true, :numericality => { :only_integer => true }

  belongs_to :creator, :class_name => "User"

  has_many :acceptable_invites, dependent: :destroy

  def invitees_info=(invitees_info)
    # If we ever need to append rather than re-assign the invites
    # this will be a problem.  But for now, once we choose who to invite
    # we never go back.  Save that shit for v2.

    self.acceptable_invites = invitees_info.map do |invitee_info|
      info = invitee_info.split(",")
      AcceptableInvite.new(:fb_id => info.first, :name => info.last.strip)
    end
  end
  
  def in_progress?
    if (self.acceptable_invites.attending.count < self.headcount) && (self.start_datetime > Time.now)
     #hasn't reached max goal and still is in the future
      true
    else
      false
    end
  end

  def full?
    if self.acceptable_invites.attending >= self.headcount
      true
    else
      false
    end
  end

  def self.tracked #events that are to be tracked by the background processes
    all_events = Event.all
    tracking = []
    all_events.each do |event|
      if event.in_progress?
        tracking << event
      end
    end
    tracking
  end

  def to_facebook_params
    facebook_params = {
        :name => self.name,
        :description => self.description,
        :start_time => self.start_datetime,
        :end_time => self.end_datetime,
        :location => self.location,
        :privacy_type => 'SECRET'
    }
  end

end