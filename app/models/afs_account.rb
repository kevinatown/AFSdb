class AfsAccount < ActiveRecord::Base
	belongs_to :account_type
	has_many :expenses

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', name: 'AFSAccounts', afs_account: 'AccountType') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			a = AfsAccount.create!( id: hash[:id], name: hash[:name]
	          				)
	          			a.account_type = AccountType.where(name: hash[:afs_account]).first 
	          			a.save!                    
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
