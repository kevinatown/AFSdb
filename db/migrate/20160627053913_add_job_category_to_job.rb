class AddJobCategoryToJob < ActiveRecord::Migration
  def change
    add_reference :jobs, :job_category, index: true
  end
end
