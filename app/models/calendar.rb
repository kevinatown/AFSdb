class Calendar < ActiveRecord::Base
	has_and_belongs_to_many :car
	has_and_belongs_to_many :staff
	has_and_belongs_to_many :contractor
	has_and_belongs_to_many :driver
	belongs_to :event_type
	belongs_to :job
	has_one :property, through: :job
	has_many :profiles, through: :staff

	validates :description, presence: true, length: { 
		within: 0..100,
		description: "Must be between 0 and 100 characters." 
	}
	validates :location, allow_blank: true, length: { 
		within: 0..55,
		description: "Must be between 0 and 55 characters." 
	}
	validates :notes, allow_blank: true, length: { 
		within: 0..1500,
		description: "Can be between 0 and 1500 characters." 
	}
	validates :event_start, presence: true
	validates :event_finish, presence: true

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'ID', event_start: 'EventStartDate', event_finish: 'EventFinishDate', 
	      		event_start_time: 'EventStartTime', event_finish_time: 'EventFinishTime', event_type: 'EventType',
	      		job_id: 'JobID', location: 'Location', car_id: 'Automobile', driver: 'StaffDriver', 
	      		description: 'EventDescription', staff: 'StaffAttending', contractor: 'ContractorAttending',
	      		notes: 'Notes') do |hash|        
	        	if hash[:id] == "ID"
	          	#puts hash.inspect
	        	else
	          		begin
	          			if hash[:description].present?
	          				d = hash[:description]
	          			else
	          				d = 'None given'
	          			end
	          			if hash[:event_start_time]
	          				stime= DateTime.strptime([hash[:event_start],hash[:event_start_time]].join(' '), '%m/%d/%Y %l:%M %p')
	          			else
	          				stime= DateTime.strptime(hash[:event_start], '%m/%d/%Y')
	          			end
	          			if hash[:event_finish_time]
	          				ftime = DateTime.strptime([hash[:event_finish],hash[:event_finish_time]].join(' '), '%m/%d/%Y %l:%M %p')
	          				allday= true
	          			else
	          				ftime = DateTime.strptime(hash[:event_finish], '%m/%d/%Y')
	          				allday= false
	          			end
		          		c = Calendar.create!(id: hash[:id], location: hash[:location], notes: hash[:notes],
	          				description: d, allday: allday,
	          				event_start: stime,
	          				event_finish: ftime,
	          				)
		          		c.car = Car.where(color: hash[:car_id])
		          		c.job = Job.where(id: hash[:job_id]).first
		          		if hash[:staff]
							c.staff = Staff.where(l_name: hash[:staff].split(", "))
		          		end
		          		c.save!                   
	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end

	# def self.between(event_start, event_end)
	#    where('start_at > :lo and start_at < :up',
	#       :lo => Event.format_date(event_start),
	#       :up => Event.format_date(event_end)
	#    )
 #  	end
 #  	def self.format_date(date_time)
 #   		Time.at(date_time.to_i).to_formatted_s(:db)
 #  	end

	# def as_json(options = {})
	# {
	#   :id => self.id,
	#   :title => self.description,
	#   :start => self.event_start,
	#   :end => self.event_end,
	#   :allDay => nil,
	#   :user_name => self.staff,
	#   :url => Rails.application.routes.url_helpers.events_path(id),
	#   :color => "green"
	# }
	# end
