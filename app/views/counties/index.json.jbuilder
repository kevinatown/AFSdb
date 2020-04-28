json.array!(@counties) do |county|
  json.extract! county, :id, :county
  json.url county_url(county, format: :json)
end
