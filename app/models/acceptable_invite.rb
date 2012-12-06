class AcceptableInvite < ActiveRecord::Base
  attr_accessible :event_id, :fb_id, :invited, :accepted, :maybe, :no
  belongs_to :event

  def self.pending_batch
    AcceptableInvite.where(:invited => false)
  end

  def self.awaiting_reply
    AcceptableInvite.where(:invited => true, :maybe => false, :no => false, :accepted => false)
  end

  def self.attending
    AcceptableInvite.where(:invited => true, :accepted => true)
  end

  def self.maybe_attending
    AcceptableInvite.where(:invited => true, :maybe => true)
  end

  def self.not_attending
    AcceptableInvite.where(:invited => true, :no => true)
  end

  def invite
    update_attributes(:invited => true)
  end

  def accepted
    update_attributes(:invited => true, :accepted => true, :maybe => false, :no => false)
  end

  def maybe
    update_attributes(:invited => true, :accepted => false, :maybe => true, :no => false)
  end

  def no
    update_attributes(:invited => true, :accepted => false, :maybe => false, :no => true)
  end
end