class Event < ActiveRecord::Base
   attr_accessible :name, :description, :creator_id, :start_datetime, :end_datetime, :location, :headcount_min, :headcount_max
  validates :name, :presence => true
  validates :description, :presence => true
  validates :creator_id, :presence => true
  validates :start_datetime, :presence => true
  validates :end_datetime, :presence => true
  validates :location, :presence => true
  validates :headcount_min, :presence => true
  validates :headcount_max, :presence => true

  belongs_to :creator, :class_name => "User"

  has_many :event_users
  has_many :guests, :through => :event_users, :source => :user
end
