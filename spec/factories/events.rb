require 'faker'

start_time = Time.now + 86400 + rand(86400)

FactoryGirl.define do
  factory :event do |f|
    f.name { Faker::Lorem.words }
    f.description { Faker::Lorem.paragraph }
    f.creator :factory => :user
    f.start_datetime { start_time }
    f.end_datetime { start_time + 3600 }
    f.location { Faker::Lorem.words }
  end

end