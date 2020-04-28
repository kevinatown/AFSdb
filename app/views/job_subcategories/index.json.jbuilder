json.array!(@job_subcategories) do |job_subcategory|
  json.extract! job_subcategory, :id, :name
  json.url job_subcategory_url(job_subcategory, format: :json)
end
