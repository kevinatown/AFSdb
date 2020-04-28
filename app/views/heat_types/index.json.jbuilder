json.array!(@heat_types) do |heat_type|
  json.extract! heat_type, :id, :name
  json.url heat_type_url(heat_type, format: :json)
end
