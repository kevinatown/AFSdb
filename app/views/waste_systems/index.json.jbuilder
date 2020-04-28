json.array!(@waste_systems) do |waste_system|
  json.extract! waste_system, :id, :name
  json.url waste_system_url(waste_system, format: :json)
end
