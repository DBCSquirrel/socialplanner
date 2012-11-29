class EventUser < ActiveRecord::Base

  attr_accessible :accepted
  belongs_to :event
  belongs_to :user

end
