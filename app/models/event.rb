class Event < ActiveRecord::Base
  attr_accessible :id, :created_at, :updated_at, :name, :description, :creator_id, :start_datetime, :end_datetime, :location, :headcount_min, :headcount_max, :private
  validates :name, :presence => true
  validates :creator_id, :presence => true

  validates :start_datetime, :presence => true
  validates :end_datetime, :presence => true

  belongs_to :creator, :class_name => "User"

  has_many :event_users, :dependent => :destroy
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

  def headcount
    accepted_guests.length
  end

  def active?
    if self.headcount_min == nil || self.headcount_min <= self.headcount
      true
    else
      false
    end
  end

  private
  def add_creator_to_event
    self.accepted_guests << self.creator
  end

end