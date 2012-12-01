class EventUser < ActiveRecord::Base

  attr_accessible :accepted, :user_id, :event_id
  belongs_to :event
  belongs_to :user

  validates :user_id, :presence => true
  validates :event_id, :presence => true

end
