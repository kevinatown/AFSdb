json.array!(@clients) do |client|
  json.extract! client, :id, :company, :address, :city, :state, :zip, :phone, :fax, :email, :website, :note
  json.url client_url(client, format: :json)
end
