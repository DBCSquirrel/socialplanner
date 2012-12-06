class AcceptableInvite < ActiveRecord::Base
  attr_accessible :event_id, :fb_id, :invited
  belongs_to :event

  def pending_batch
    where(:invited => false)
  end

  def awaiting_reply
    where(:invited => true, :maybe => false, :no => false, :accepted => false)
  end

  def attending
    where(:invited => true, :accepted => true)
  end

  def maybe_attending
    where(:invited => true, :maybe => true)
  end

  def not_attending
    where (:invited => true, :no => true)
  end

  def invite
    update_attributes(:invited => true)
  end

  def accepted
    update_attributes(:invited => true, :accepted => :true, :maybe => false, :no => false)
  end

  def maybe
    update_attributes(:invited => true, :accepted => :false, :maybe => true, :no => false)
  end

  def no
    update_attributes(:invited => true, :accepted => :false, :maybe => false, :no => true)
  end
end