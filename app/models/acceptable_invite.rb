class AcceptableInvite < ActiveRecord::Base
  attr_accessible :event_id, :fb_id, :state
  belongs_to :event

  validate :state, :inclusion => {:in => %w(pending sent attending maybe declined)}

  before_create do
    self.state = 'pending'
  end

  def self.with_state(state)
    where(:state => state)
  end

  def self.pending
    with_state('pending')
  end

  def self.sent
    with_state('sent')
  end

  # Facebook calls the states attending, maybe, and declined
  def self.attending
    with_state('attending')
  end

  def self.declined
    with_state('declined')
  end

  def self.maybe
    with_state('maybe')
  end

  def sent!
    update_attributes(:state => 'sent')
  end

  def attending!
    update_attributes(:state => 'attending')
  end

  def declined!
    update_attributes(:state => 'declined')
  end
end