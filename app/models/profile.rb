class Profile < ActiveRecord::Base
	belongs_to :user, inverse_of: :profile
	has_one :staff, through: :user
	has_many :calendar, through: :staff

	# def start_time
 #        if self.user.is_admin
 #        	Calendar.all
 #        else
 #        	puts 'here'
 #        	self.staff.calendar
 #        end
 #    end
end
