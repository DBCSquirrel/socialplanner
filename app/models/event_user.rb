class EventUser < ActiveRecord::Base

  attr_accessible :accepted, :user_id, :event_id
  belongs_to :event
  belongs_to :user

  validates :user_id, :presence => true
  validates :event_id, :presence => true

  def accept
    if self.event.headcount_max
      if self.event.headcount_max <= self.event.headcount
        return false
      end
    end
    self.accepted = true
    self.save!
  end

end
