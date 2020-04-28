class AddJobSubcategoryToJob < ActiveRecord::Migration
  def change
    add_reference :jobs, :job_subcategory, index: true
  end
end
