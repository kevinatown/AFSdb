json.array!(@contractors) do |contractor|
  json.extract! contractor, :id, :name, :address, :city, :state, :zip, :phone, :fax, :emails, :website, :notes
  json.url contractor_url(contractor, format: :json)
end
