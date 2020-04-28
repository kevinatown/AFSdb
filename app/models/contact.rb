class Contact < ActiveRecord::Base
	belongs_to :client
	
	def fullname
    	"#{f_name} #{l_name} "
  	end

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', fname: 'FirstName', lname: 'LastName', company:'Company',
	      		phone: 'Phone', email: 'Email', title: 'Title', ext: 'Extension') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin   
		          		c = Contact.create!( id: hash[:id], f_name: hash[:fname], l_name: hash[:lname],
		          				phone: hash[:phone], title: hash[:title], extension: hash[:ext], email: hash[:email])
		          		if hash[:company]
		          		 	c.client = Client.where(name: hash[:company]).first 
		          		end 
		          		c.save!                   
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
