json.array!(@calendars) do |calendar|
  json.extract! calendar, :id
  json.title calendar.description
  json.description calendar.notes
  json.start calendar.event_start
  json.end calendar.event_finish
  json.url calendar_url(calendar, format: :json)
end
