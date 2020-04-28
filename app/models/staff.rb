class Staff < ActiveRecord::Base
	alias_attribute :name, :fullname
	has_one :user, inverse_of: :staff, dependent: :destroy
	has_and_belongs_to_many :job
	has_and_belongs_to_many :calendar
	# has_and_belongs_to_many :driver, join_table: 'calendars_drivers', primary_key:'driver_id'
	has_one :driver, inverse_of: :staff, dependent: :destroy
	accepts_nested_attributes_for :driver, allow_destroy: true
	has_many :expenses
	has_many :time_clocks, dependent: :destroy
	belongs_to :state
	belongs_to :street_type
	belongs_to :employment_type
	belongs_to :streetdir

	after_create :create_user_account

	validates :f_name, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	validates :l_name, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	# validates :email, format: {with: /\d{3}[-]\d{3}[-]\d{4}/} 
	validates :phone, presence: true, format: {with: /[(]?\d{3}[-). ]*\d{3}[ .-]?\d{4}/}
	validates :state, presence: true
	validates :street_type, presence: true
	validates :street_name, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	validates :street_number, presence: true, length: { 
		within: 1..50,
		wrong_length: "Must be between 1 and 50 characters." 
	}
	validates :city, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	validates :zip, presence: true, length: { 
		is: 5,
		wrong_length: "Must be 5 characters." 
	}

	def create_user_account
		if self.l_name.length >= 4
			User.create!(username: self.f_name[0, 2] + self.l_name[0, 4], password: self.l_name[-4..-1] + self.phone[-4..-1],
          		password_confirmation: self.l_name[-4..-1] + self.phone[-4..-1], staff_id: self.id)
		else

			User.create!(username: self.f_name[0, 2] + self.l_name[0, 4], password: self.l_name[-self.l_name.length..-1] + self.phone[-4..-1],
          		password_confirmation: self.l_name[-self.l_name.length..-1] + self.phone[-4..-1], staff_id: self.id)
		end
   	end

	def fullname
    	"#{f_name} #{l_name} "
  	end

  	def get_rate
  		self.hourly_wage.present? ? self.hourly_wage : 0
  	end

  	def address
		s = "#{street_number} #{street_name} "
		if self.streetdir.present?
			s += self.streetdir.name + ' '
		end
		if self.street_type.present?
			s += self.street_type.name + ' '
		end
		s += "#{city}"
		if self.state.present?
			s+= ", " + self.state.name
		end
		s	
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
	          			s = Staff.create!( id: hash[:id], f_name: hash[:fname], m_name: hash[:mname], l_name: hash[:lname],
	          				city: hash[:city], zip: hash[:zip], phone: hash[:phone],
	          				email: hash[:email], notes: hash[:notes],
	          				skills: hash[:skills], limitations: hash[:limitations], street_name: hash[:street_name],
	          				street_number: hash[:street_num], suite: hash[:suite], hire_date: hash[:hire_date],
	          				termination_date: hash[:termination_date], position: hash[:position],
	          				hourly_wage: hash[:hourly_wage], annual_salary: hash[:annual_salary]
	          				)
	          			s.state = State.where(name: hash[:state]).first
	          			s.streetdir = Streetdir.where(name: hash[:street_dir_id]).first 
	          			s.street_type = StreetType.where(name: hash[:street_type_id]).first
						s.employment_type = EmploymentType.where(name: hash[:empoloyment_type_id]).first
						s.save!
						            
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
