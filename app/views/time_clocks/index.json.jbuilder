json.array!(@time_clocks) do |time_clock|
  json.extract! time_clock, :id, :time_in, :time_out, :lat_in, :long_in, :lat_out, :long_out, :notes
  json.url time_clock_url(time_clock, format: :json)
end
