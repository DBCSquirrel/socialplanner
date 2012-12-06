class Event < ActiveRecord::Base
  after_initialize :set_default_headcount_min

  attr_accessible :id, :created_at, :updated_at, :name, :description,
                  :creator_id, :start_datetime, :end_datetime, :location,
                  :headcount_min, :headcount_max, :private, :invitee_ids,
                  :fb_id

  validates :name, :presence => true
  validates :creator, :presence => true
  # validates :fb_id, :presence => true #DELETE THIS WHEN MERGING

  validates :start_datetime, :presence => true
  validates :end_datetime, :presence => true

  validates :headcount_min,
            :numericality => {:only_integer => true, :greater_than => 0}

  validates :headcount_max,
            :numericality => {:greater_than_or_equal_to => :headcount_min, :only_integer => true},
            :allow_nil => true

  belongs_to :creator, :class_name => "User"

  has_many :acceptable_invites

  def invitee_ids=(invitee_ids)
    self.acceptable_invites = invitee_ids.map do |invitee_id|
      AcceptableInvite.new(:fb_id => invitee_id, :invited => false)
    end
  end

  def in_progress?
    if self.acceptable_invites < self.headcount_max && self.start_datetime > Time.now
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
    all_events = Event.all #event has not yet taken place, and headcount max has not yet been met
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
end