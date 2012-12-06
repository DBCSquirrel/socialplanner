# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:uid) { |n| "555535555#{n}" }
  factory :user do
    provider "facebook"
    uid { generate(:uid) }
    name { Faker::name }
    oauth_token "DASVAERGH2345647regGDSFsdfgSERTF"
    oauth_expires_at "2012-11-27 16:51:41"
  end
end
