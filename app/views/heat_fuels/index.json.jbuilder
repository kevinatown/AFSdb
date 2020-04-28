json.array!(@heat_fuels) do |heat_fuel|
  json.extract! heat_fuel, :id, :name
  json.url heat_fuel_url(heat_fuel, format: :json)
end
