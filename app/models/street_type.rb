class StreetType < ActiveRecord::Base
	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each( name: 'StreetType') do |hash|        
	        	if hash[:name] == "StreetType"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			StreetType.create!( name: hash[:name] )                     
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
