# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "21345678540032"
    name "Billy-Bob Honduras?"
    oauth_token "DASVAERGH#2345647regGDSFsdfgSERTF"
    oauth_expires_at "2012-11-27 16:51:41"
  end
end
