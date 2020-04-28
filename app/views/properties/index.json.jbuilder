json.array!(@properties) do |property|
  json.extract! property, :id, :street_number, :street_name, :suite, :city, :zip, :bldg_sqr_feet, :lot_sqr_feet, :lot_acreage, :year_built, :notes, :lockbox_code
  json.url property_url(property, format: :json)
end
