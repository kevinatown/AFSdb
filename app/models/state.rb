class State < ActiveRecord::Base
	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(one: 'one',two: 'FullStats',name: 'AB') do |hash|        
	        	if hash[:name] == "AB"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			State.create!( name: hash[:name] )                     
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
