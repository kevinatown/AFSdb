class Contractor < ActiveRecord::Base
	belongs_to :state
	belongs_to :contractor_category
	has_many :jobs

	validates :name, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	# validates :email, format: {with: /\d{3}[-]\d{3}[-]\d{4}/} 
	validates :phone, presence: true, format: {with: /[(]?\d{3}[-). ]*\d{3}[ .-]?\d{4}/}
	validates :state, presence: true
	validates :city, presence: true
	validates :address, presence: true
	validates :zip, presence: true, length: { 
		is: 5,
		wrong_length: "Must be 5 characters." 
	}
	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', name: 'CompanyName', cat: 'ContractorCategory', add:'Address',
	      		city: 'City', state: 'State', zip: 'Zip', phone: 'Phone', fax: 'Fax', 
	      		email: 'email', website: 'website', notes: 'Notes') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			c=Contractor.create!( id: hash[:id], name: hash[:name], address: hash[:add],
	          				city: hash[:city], zip: hash[:zip], phone: hash[:phone], fax: hash[:fax],
	          				email: hash[:email], website: hash[:website], notes: hash[:notes]
	          				) 
	          			c.contractor_category = ContractorCategory.where(name: hash[:cat]).first
	          			c.state = State.where(name: hash[:state]).first
	          			c.save!                    
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end