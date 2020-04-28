class TimeClock < ActiveRecord::Base
	belongs_to :job
	belongs_to :staff
	
	validate do |time_clock|
  		if time_clock.time_out.present? and time_clock.time_out < time_clock.time_in
    		errors.add(:time_out, "You cannot sign out before you signed in!")
  		end
	end
	validates :staff, presence: true

	# validates :time_out, date: { after: :time_in, message: "You cannot sign out before you signed in!" }

	# def valid_time_out
	# 	if (time_out != nil)
 #     		errors.add(:time_out, "You cannot sign out before you signed in!") unless (birthdate < :)
 #    end
	# end

	def invoice
		if self.job.present?
			self.job.invoice
		else
			''
		end
	end


	def wages_owed
		if self.time_out.present?
			hours = (self.time_out - self.time_in) / 1.hour
			self.staff.get_rate * hours
		else
			0
		end		
	end

	def hours
		if self.time_out.present?
			hours = (self.time_out - self.time_in) / 1.hour
		else
			0
		end
	end
	
	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', staff_id: 'Employee', date: 'DateWorked', 
	      		time_in: 'TimeIn', time_out: 'TimeOut', job: 'JobID', notes: 'Notes') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin
	          			staff_name = hash[:staff_id].split(' ')
	          			date_in = [hash[:date], hash[:time_in].split(' ')[1]].join(' ')
	          			date_out = [hash[:date], hash[:time_out].split(' ')[1]].join(' ')
	          			tc = TimeClock.create!(id: hash[:id], time_in: date_in, time_out: date_out, notes: hash[:notes]
		          				)
		          		tc.staff = Staff.where(l_name: staff_name[1], f_name: staff_name[0]).first
		          		if hash[:job]	
		          			tc.job = Job.where(id: hash[:job].split(', '))
		          		end
		          		tc.save!       
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
