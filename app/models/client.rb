class Client < ActiveRecord::Base
	belongs_to :state
	belongs_to :company_category

	validates :state, presence: true
	validates :address, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	validates :city, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	validates :zip, presence: true, length: { 
		is: 5,
		wrong_length: "Must be 5 characters." 
	}
	validates :phone, presence: true, format: {with: /[(]?\d{3}[-). ]*\d{3}[ .-]?\d{4}/}

	def full_address
		"#{address} #{city}, #{state.name} #{zip} "
	end

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', name: 'CompanyName', cat: 'CompanyName', add:'Address',
	      		city: 'City', state: 'State', zip: 'Zip', phone: 'Phone', fax: 'Fax', 
	      		email: 'email', website: 'website', notes: 'Notes') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			c= Client.create!( id: hash[:id], name: hash[:name], address: hash[:add],
	          				city: hash[:city], zip: hash[:zip], phone: hash[:phone], fax: hash[:fax],
	          				email: hash[:email], website: hash[:website], notes: hash[:notes]
	          				)
	          			c.company_category = CompanyCategory.where(name: hash[:cat]).first
	          			c.state_id = State.where(name: hash[:state]).first
	          			c.save!
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
