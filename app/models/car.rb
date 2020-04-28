class Car < ActiveRecord::Base
	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'CarID', model_year: 'ModelYear', make: 'Make', model: 'Model', color: 'Color', nickname: 'Nickname') do |hash|        
	        	if hash[:id] == "CarID"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			Car.create!( id: hash[:id], model_year: hash[:model_year], make: hash[:make], 
	          				model: hash[:model], color: hash[:color], nickname: hash[:nickname] )                     
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
