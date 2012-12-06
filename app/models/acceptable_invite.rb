class AcceptableInvite < ActiveRecord::Base
  attr_accessible :event_id, :fb_id, :invited
  belongs_to :event

end
