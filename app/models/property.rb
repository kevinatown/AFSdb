class Property < ActiveRecord::Base
	has_many :jobs, dependent: :destroy
	belongs_to :state
	belongs_to :street_type
	belongs_to :water_source
	belongs_to :waste_system
	belongs_to :heat_type
	belongs_to :heat_fuel
	belongs_to :streetdir
	belongs_to :contact
	belongs_to :client

	validates :state, presence: true
	validates :street_type, presence: true
	# validates :contact, presence: true
	# validates :client, presence: true
	validates :street_name, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	validates :street_number, presence: true, length: { 
		within: 1..50,
		wrong_length: "Must be between 1 and 50 characters." 
	}
	validates :city, presence: true, length: { 
		within: 1..150,
		wrong_length: "Must be between 1 and 150 characters." 
	}
	validates :zip, presence: true, length: { 
		is: 5,
		wrong_length: "Must be 5 characters." 
	}

	def address
		s = "#{street_number} #{street_name} "
		if self.streetdir.present?
			s += self.streetdir.name + ' '
		end
		if self.street_type.present?
			s += self.street_type.name + ' '
		end
		s += "#{city}"
		if self.state.present?
			s+= ", " + self.state.name
		end
		s	
	end

	def self.import(file)
    	spreadsheet = Roo::Spreadsheet.open(file, extension: :xlsx)
    	header = spreadsheet.row(1)     
    	ActiveRecord::Base.transaction do
	      	spreadsheet.each(id: 'PropID', street_number: 'StreetNum', street_name: 'StreetName', strtype:'StType:',
	      		strdir: 'StDir',suite:'SuiteNum',city: 'City', county:'County',state:'State', zip: 'Zip', 
	      		cpsprop: 'CPSProperty', cpsclient: 'CPSClient', cpsprog:'CPSProgram', bldgt:'BldgType',
	      		bldgsqft: 'BldgSqFoot', lotsq: 'LotSqFoot', lotacre: 'LotAcreage', year_built:'YearBuilt',
	      		htype:'HeatType', hfuel: 'HeatFuel', wsource: 'WaterSource', wsys:'WasteSystem', notes: 'Notes',
	      		wheatfuel: 'WaterHeaterFuel', stvf: 'StoveRangeFuel', lockbox_code: 'Lockbox Code') do |hash|        
	        	if hash[:id] == "PropID"
	          	#puts hash.inspect
	        	else
	          		begin      
	          			p = Property.create!( id: hash[:id], street_number: hash[:street_number], 
	          				street_name: hash[:street_name], suite: hash[:suite],
	         				city: hash[:city], zip: hash[:zip], notes: hash[:notes], 
	         				cps_property: hash[:cpsprop], cps_client: hash[:cpsclient], cps_program:hash[:cpsprog],
	         				bldg_sqr_feet: hash[:bldgsqft], lot_sqr_feet: hash[:lotsq], lot_acreage: hash[:lotacre],
	         				year_built: hash[:year_built], is_closed: false,
	         				lockbox_code: hash[:lockbox_code]
	          				)
	          			p.state = State.where(name: hash[:state]).first
	          			p.heat_type = HeatType.where(name: hash[:htype]).first
	         			p.heat_fuel = HeatFuel.where(name: hash[:hfuel]).first
	         			p.waste_system = WasteSystem.where(name: hash[:wsys]).first
	         			p.water_source = WaterSource.where(name: hash[:wsource]).first
	         			p.street_type = StreetType.where(name: hash[:strtype]).first
	          			p.streetdir = Streetdir.where(name: hash[:strdir]).first
	         			p.save!

	          		#sleep 0.25 #added to prevent query limit
	          		end          
	        	end
			end
		end 
    end
end
