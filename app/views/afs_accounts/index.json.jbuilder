json.array!(@afs_accounts) do |afs_account|
  json.extract! afs_account, :id, :name
  json.url afs_account_url(afs_account, format: :json)
end
