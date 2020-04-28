json.array!(@expenses) do |expense|
  json.extract! expense, :id, :date_incurred, :vendor_name, :vendor_location, :description, :ammount, :notes
  json.url expense_url(expense, format: :json)
end
