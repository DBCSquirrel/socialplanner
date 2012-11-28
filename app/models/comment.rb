class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type
  validates :body, :presence => true
  validates :commentable_id, :presence => true, :numericality => true
  validates :commentable_type, :presence => true, :format => {:with => /(^Comment$|^Event$)/, :message =>"must be 'Comment' or 'Event'" }
end
