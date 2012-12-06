class Event < ActiveRecord::Base
  after_initialize :set_default_headcount_min

  attr_accessible :id, :created_at, :updated_at, :name, :description,
                  :creator_id, :start_datetime, :end_datetime, :location,
                  :headcount_min, :headcount_max, :private, :invitee_ids

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

  has_many :event_users, :dependent => :destroy

  has_many :comments, :as => :commentable
  has_many :acceptable_invites

  has_many :guests,
           :through => :event_users,
           :source => :user

  has_many :invited_guests,
           :through => :event_users,
           :source => :user,
           :conditions => EventUser.invited.where_clauses

  has_many :accepted_guests,
           :through => :event_users,
           :source => :user,
           :conditions => EventUser.accepted.where_clauses

  has_many :comments, :as => :commentable

  after_create :add_creator_to_event

  def invitee_ids=(invitee_ids)
    self.acceptable_invites = invitee_ids.map do |invitee_id|
      AcceptableInvite.new(:fb_id => invitee_id, :invited => false)
    end
  end

  def headcount
    accepted_guests.length
  end

  def active?
    if self.headcount_max < self.headcount
      true
    else
      false
    end
  end

  def self.tracked #events that are to be tracked by the background processes
    @all_events = Event.all
    @tracking = []
    @all_events.each do |event|
      if event.active?
        @tracking << event
      end
    end
    @tracking
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

  def add_creator_to_event
    self.accepted_guests << self.creator
  end

end