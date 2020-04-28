json.array!(@company_categories) do |company_category|
  json.extract! company_category, :id, :name
  json.url company_category_url(company_category, format: :json)
end
