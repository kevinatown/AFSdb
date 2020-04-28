json.array!(@staffs) do |staff|
  json.extract! staff, :id, :f_name, :m_name, :l_name, :driver_lic_num, :driver_lic_exp, :skills, :limitations, :email, :phone, :street_num, :street_name, :suite, :city, :zip, :hire_date, :termination_date, :position, :notes, :hourly_wage, :annual_salary
  json.url staff_url(staff, format: :json)
end
