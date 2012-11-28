# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

comment_type = ['Comment','Event']
comment_type = comment_type[rand(2)]

FactoryGirl.define do
  factory :comment do |f|
    f.body { Faker::Lorem.paragraph }
    f.commentable_type { comment_type }
    f.commentable_id { rand(20) }
  end
end
