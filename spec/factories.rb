FactoryGirl.define do
  factory :event do
    name 'The Wine Gala for Whistling Willie'
    description 'this is a description about'
    admin_id 1
    start_datetime '2012-12-12 10:15:00 -0800'
    end_datetime '2012-12-12 12:15:00 -0800'
    location 'DBC, yo'
  end

end