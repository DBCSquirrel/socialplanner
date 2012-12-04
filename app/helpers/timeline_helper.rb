module TimelineHelper

  def event_length(event) # calculate length in minutes
    (event.end_datetime - event.start_datetime) / 60
  end

  def event_start_position(event)
    (event.start_datetime - (Time.now.midnight)) / 60 # + 9.hours
  end
end