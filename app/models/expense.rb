class Expense < ActiveRecord::Base
	belongs_to :expense_type
	belongs_to :staff
	belongs_to :afs_account
	belongs_to :job

	validates :expense_type, presence: true
	validates :amount, presence: true, numericality: {
		greater_than_or_equal_to: 0
	}
	validates :staff, presence: true
	validates :description, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters."
		}
	validates :date_incurred, presence: true

	def invoice
		if self.job.present?
			self.job.invoice
		else
			''
		end
	end

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', date_incurred: 'DateIncurred', vendor_name: 'VendorName', 
	      		vendor_location: 'VendorLocation', description: 'Description', amount: 'Amount',
	      		job_id: 'Job#', afs_account_id: 'PaymentMethod', expense_type_id: 'ExpenseType',
	      		staff_id: 'WhoIncurred', notes: 'Notes') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin	      
	          			e = Expense.create!(id: hash[:id], vendor_location: hash[:vendor_location], notes: hash[:notes],
	          				description: hash[:description], date_incurred: hash[:date_incurred],
	          				amount: hash[:amount], vendor_name: hash[:vendor_name]
	          				)
          				e.expense_type = ExpenseType.where(name: hash[:expense_type_id]).first
          				e.afs_account = AfsAccount.where(name: hash[:afs_account_id]).first
          				e.staff = Staff.where(l_name: hash[:staff_id]).first
		          		if hash[:job_id]
		          			e.job = Job.where(id: hash[:job_id].split(', '))
		          		end     
		          		e.save!              
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
