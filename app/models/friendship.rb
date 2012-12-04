class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id
  validates :friend_id, :presence => true, :numericality => true
  validates :user_id, :presence => true, :numericality => true

  belongs_to :user
  belongs_to :friend, :class_name => "User"

end