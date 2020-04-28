json.array!(@cars) do |car|
  json.extract! car, :id, :model_year, :make, :model, :color, :nickname
  json.url car_url(car, format: :json)
end
