json.array!(@water_sources) do |water_source|
  json.extract! water_source, :id, :name
  json.url water_source_url(water_source, format: :json)
end
