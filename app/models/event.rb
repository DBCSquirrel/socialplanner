class Event < ActiveRecord::Base
  after_initialize :set_default_headcount_min, :set_default_headcount_max

  attr_accessible :id, :created_at, :updated_at, :name, :description,
                  :creator_id, :start_datetime, :end_datetime, :location,
                  :headcount_min, :headcount_max, :private, :invitee_ids,
                  :fb_id, :invited

  validates :name, :presence => true
  validates :creator, :presence => true

  validates :start_datetime, :presence => true
  validates_datetime :end_datetime, :after => :start_datetime, :after_message => "must be set a time after event start time"
  
  validates :end_datetime, :presence => true
  validates_datetime :start_datetime, :after => lambda { 1.hour.from_now }, :after_message => "must be at least an hour from now"

  validates :headcount_min,
            :numericality => {:only_integer => true, :greater_than => 0}

  validates :headcount_max,
            :numericality => {:greater_than_or_equal_to => :headcount_min, :only_integer => true},
            :allow_nil => true

  belongs_to :creator, :class_name => "User"

  has_many :acceptable_invites

  def invitee_ids=(invitee_ids)
    # If we ever need to append rather than re-assign the invites
    # this will be a problem.  But for now, once we choose who to invite
    # we never go back.  Save that shit for v2.

    self.acceptable_invites = invitee_ids.map do |invitee_id|
      AcceptableInvite.new(:fb_id => invitee_id)
    end
  end
  
  def in_progress?
    if (self.acceptable_invites.attending.count < self.headcount_max) && (self.start_datetime > Time.now)
     #hasn't reached max goal and still is in the future
      true
    else
      false
    end
  end

  def full?
    if self.acceptable_invites.attending >= self.headcount_max
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
        :privacy_type => 'SECRET'
    }
  end

  private

  def set_default_headcount_min
    self.headcount_min ||= 1
  end
  
  def set_default_headcount_max
    self.headcount_max ||= 20
  end
end