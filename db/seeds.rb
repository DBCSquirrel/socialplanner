# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# if Rails.env.development?
#   u = User.create name: "Sarah SoRelle",
#                   oauth_token: "fjdksla;fjdksajfdkls",
#                   uid: "12334252345245",
#                   provider: "facebook"
#   (1...5).each do |i|
#     u.created_events.create name: "Task #{i}",
#                             start_datetime: (i*1).hours.from_now,
#                             end_datetime: (i*1+1).hours.from_now
#   end
# end