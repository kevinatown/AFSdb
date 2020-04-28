json.array!(@contractor_categories) do |contractor_category|
  json.extract! contractor_category, :id, :name
  json.url contractor_category_url(contractor_category, format: :json)
end
