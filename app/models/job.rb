class Job < ActiveRecord::Base
	# has_one :contractor
	has_and_belongs_to_many :staff
	has_many :expenses #, dependent: :destroy
	has_many :time_clocks #, dependent: :destroy
	belongs_to :property
	belongs_to :job_category
	belongs_to :job_subcategory
	belongs_to :invoice
	belongs_to :contact
	belongs_to :project
	belongs_to :client
	belongs_to :contractor
	has_many :accounts_payable
	# belongs_to :contact, through: :client

	validates :job_category, presence: true
	validates :afs_price, presence: true, numericality: {
		greater_than_or_equal_to: 0
	}
	validates :status, presence: true
	# validates :description, presence: true, length: { 
	# 	within: 1..150,
	# 	wrong_length: "Must be between 1 and 150 characters."
	# 	}

	def percent_profit
		self.profit/self.afs_price*100
	end

	def profit
		self.afs_price - self.total_expense
	end

	def total_expense
		[self.contractor_price, self.get_wages_paid, self.materials_cost, self.misc_cost].sum { |e| e.to_f }
	end 

	def actual_profit
		self.payment - self.total_expense
	end

	def actual_profit_percent
		self.actual_profit/self.payment*100
	end

	def payment_late
		if self.anticipated_payment_date.present?
			self.anticipated_payment_date > DateTime.now and self.date_payment_recv.present?
		else
			false 
		end 
	end
	def calc_wages_paid
		self.wages_paid = self.time_clocks.to_a.sum {|tc| tc.wages_owed.to_f }
		self.save!
	end 

	def get_wages_paid
		self.time_clocks.to_a.sum {|tc| tc.wages_owed.to_f }
	end

	def calc_material_cost
		self.materials_cost = self.expenses.to_a.sum {|e| e.amount.to_f }
		self.save!
	end 

	def invoice
		"J" + (2000 + self.id).to_s
	end

	def name
		s = ''
		s += self.invoice + ' - '
		if self.job_category.present?
			s += self.job_category.name + ' '
		end
		if self.job_subcategory.present?
			s += self.job_subcategory.name + ' '
		end
		if self.property.present?
			s += 'at ' + self.property.address
		end
		s
	end

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'JobID', date_approved: 'DateApproved:', client: 'Client:', contact: 'Contact:',
	      		date_assigned: 'Date Assigned:', contractor: 'Contractor:', add:'PropertyAddress:', carrington_property: 'CarringtonProperty?',
	      		job_category: 'Job Category:', job_subcategory: 'JobSubCategory:', date_due: 'DateDue:', tasks: 'Tasks:',
	      		date_completed: 'DateCompleted', photos: 'PhotosResultsfromStaff', afs_price: 'AFSPrice:', date_invoiced: 'DateInvoiced:',
	      		date_payment_recv: 'DatePymntReceived:', payment: 'PaymentAmount:', client_check_number: 'ClientCheck#:',
	      		job_closed: 'JobClosed?:', notes_for_office_staff: 'NotesForOfficeStaff:', notes_for_feild_staff: 'NotesForFieldStaff:',
	      		notes_for_client: 'NotesForClient:',date_invoiced1: 'DateInvoiced:1',
	      		date_payment_recv1: 'DatePymntReceived:1', payment1: 'PaymentAmount:1', client_check_number1: 'ClientCheck#:1',
	      		job_closed1: 'JobClosed?:1', notes_for_office_staff1: 'NotesForOfficeStaff:1', notes_for_feild_staff1: 'NotesForFieldStaff:1',
	      		notes_for_client1: 'NotesForClient:1', project: 'Project', staff: 'Employee:', contractor_price: 'ContractorPrice:',
	      		wages_paid: 'WagesPaid:', materials_cost: 'MaterialsCosts:', misc_cost: 'MiscCosts:', 
	      		anticipated_payment_date: 'AnticipatedPaymentDate', invoice: 'Invoice#:') do |hash|        
	        	if hash[:id] == "JobID"
	          	#puts hash.inspect
	        	else
	          		begin
	          			if hash[:add]
	          				address_a = hash[:add].split(', ')[0].split(' ') 
	          			else
	          				address_a = [nil, nil, nil]
	          			end	
		          		j = Job.create!( id: hash[:id],
	          				date_approved: hash[:date_approved], carrington_property: hash[:carrington_property],
	          				date_due: hash[:date_due], tasks: hash[:tasks],
	          				date_completed: hash[:date_completed], afs_price: hash[:afs_price], date_invoiced: hash[:date_invoiced],
	          				date_payment_recv: hash[:date_payment_recv], payment: hash[:payment], client_check_number: hash[:client_check_number],
	          				is_closed: hash[:job_closed], notes_for_office_staff: hash[:notes_for_office_staff],
	          				notes_for_field_staff: hash[:notes_for_feild_staff], notes_for_client: hash[:notes_for_client],
	          				wages_paid: hash[:wages_paid], materials_cost: hash[:materials_cost], contractor_price: hash[:contractor_price],
	          				misc_cost: hash[:misc_cost],
	          				)
	          			j.property = Property.where(street_number: address_a[0], street_name: address_a[1], street_type_id: StreetType.where(name: address_a[2]).first).first
	          			j.job_category = JobCategory.where(name: hash[:job_category]).first
	          			j.job_subcategory = JobSubcategory.where(name: hash[:job_subcategory]).first
	          			j.contact = Contact.where(id: hash[:contact]).first
	          			j.client = Client.where(name: hash[:client]).first
	          			j.contractor = Contractor.where(name: hash[:contractor])
	          			if hash[:staff]
	          				j.staff = Staff.where(l_name: hash[:staff].split(", "))
	          			end
	          			j.save!

	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end

