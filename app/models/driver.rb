class Driver < ActiveRecord::Base
	belongs_to :staff, inverse_of: :driver
	has_one :user, through: :staff
	has_and_belongs_to_many :job
	has_and_belongs_to_many :calendar
	belongs_to :state
	belongs_to :streettype

	def fullname()
		self.staff.fullname
	end

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', fname: 'FirstName',mname: 'MiddleName', lname: 'LastName', 
	      		driver_lic_num: 'DrivLicNum', driver_lic_exp: 'DrivLicExpDate', empoloyment_type_id: 'Employment Type:',
	      		skills: 'Skills', limitations: "Limitations", email: 'EMail', phone: 'CellPhone',
	      		street_name:'StreetName', street_num:'StreetNum', street_type_id: 'StreetType', street_dir_id: 'StreetDir',
	      		suite: 'SuiteAptNum', hire_date: 'HireDate', termination_date: 'TerminationDate',
	      		position: 'Position', notes: 'Notes', cpn: 'CompanyPayeeName', hourly_wage: 'HourlyWage',
	      		annual_salary: 'AnnualSalary', divers_lic_state: 'DriversLicenseState',
	      		city: 'City', state: 'State:', zip: 'Zip') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin
	          			if hash[:driver_lic_exp].present? #and hash[:drivers_lic_state].present?
			          		d = Driver.create!( driver_lic_num: hash[:driver_lic_num],
			          			driver_lic_exp: hash[:driver_lic_exp].to_datetime,
			          			state_id: State.where(name: hash[:drivers_lic_state]),
			          			staff_id: Staff.where(id: hash[:id])
			          			)
			          		d.staff = Staff.where(id: hash[:id]).first
			          		d.state = State.where(name: hash[:drivers_lic_state]).first
			          		d.save!
			          	end                  
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
