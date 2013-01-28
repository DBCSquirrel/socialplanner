class AcceptableInvite < ActiveRecord::Base
  attr_accessible :event_id, :fb_id, :state
  belongs_to :event

  validate :state, :inclusion => {:in => %w(pending noreply attending maybe declined expired)}

  before_create do
    self.state = 'pending'
  end

  def self.with_state(state)
    where(:state => state)
  end

  def self.pending
    with_state('pending')
  end

  def self.noreply #sent out invite
    with_state('noreply')
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

  def self.expired
    with_state('expired')
  end

  def noreply!
    update_attributes(:state => 'noreply')
  end

  def attending!
    update_attributes(:state => 'attending')
  end

  def declined!
    update_attributes(:state => 'declined')
  end

  def maybe!
    update_attributes(:state => 'maybe')
  end

  def expired!
    update_attributes(:state => 'expired')
  end

  def set_state(state)
    update_attributes(:state => state)
  end
end