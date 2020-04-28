json.array!(@streetdirs) do |streetdir|
  json.extract! streetdir, :id, :name
  json.url streetdir_url(streetdir, format: :json)
end
