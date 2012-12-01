class EventUser < ActiveRecord::Base

  attr_accessible :accepted
  belongs_to :event
  belongs_to :user

  validates :user_id, :presence => true
  validates :event_id, :presence => true

end
