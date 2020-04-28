class AddPropertyToJobs < ActiveRecord::Migration
  def change
    add_reference :jobs, :property, index: true
  end
end
