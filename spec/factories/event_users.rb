# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_user do |f|
    f.user_id { rand(1..10) }
    f.event_id { rand(1..10) }
  end
end
