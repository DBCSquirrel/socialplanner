class Comment < ActiveRecord::Base
  attr_accessible :body, :commentable_id, :commentable_type
  validates :body, :presence => true
  validates :commentable_id, :presence => true
  validates :commentable_type, :presence => true
end
