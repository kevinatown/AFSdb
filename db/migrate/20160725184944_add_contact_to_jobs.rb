class AddContactToJobs < ActiveRecord::Migration
  def change
	add_reference :jobs, :contact, index: true
  end
end
