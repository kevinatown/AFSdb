class ContractorCategory < ActiveRecord::Base
	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', name: 'CompanyCategories') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			ContractorCategory.create!( id: hash[:id], name: hash[:name] )                     
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
