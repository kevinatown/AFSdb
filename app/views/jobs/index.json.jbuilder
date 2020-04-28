json.array!(@jobs) do |job|
  json.extract! job, :id, :date_approved, :date_due, :tasks, :date_completed, :afs_price, :contractor_price, :wages_paid, :materials_cost, :misc_cost, :date_invoiced, :anticipated_payment_date, :invoice_number, :date_payment_recv, :payment, :client_check_number, :job_closed, :notes_for_office_staff, :notes_for_feild_staff, :notes_for_client
  json.url job_url(job, format: :json)
end
