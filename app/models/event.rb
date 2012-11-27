class Event < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, :presence => true
  validates :description, :presence => true
  validates :admin_id, :presence => true
  validates :start_datetime, :presence => true
  validates :end_datetime, :presence => true
  validates :location, :presence => true
  validates :headcount_min, :presence => true
  validates :headcount_max, :presence => true
end
