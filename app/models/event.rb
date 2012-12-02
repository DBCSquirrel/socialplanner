class Event < ActiveRecord::Base
  attr_accessible :id, :created_at, :updated_at, :name, :description, :creator_id, :start_datetime, :end_datetime, :location, :headcount_min, :headcount_max
  validates :name, :presence => true
  validates :creator_id, :presence => true
  validates :start_datetime, :presence => true
  validates :end_datetime, :presence => true

  belongs_to :creator, :class_name => "User"

  has_many :event_users
  has_many :invited_guests, :through => :event_users, :source => :user
  has_many :comments, :as => :commentable

  def attending_guests
    invited_guests.joins(:event_users).where("event_users.accepted" => true)
    # check_for_tilt
  end

  def headcount
    invited_guests.joins(:event_users).where("event_users.accepted" => true).count
  end

end