class CreateJoinTableJobStaff < ActiveRecord::Migration
  def change
    create_join_table :jobs, :staffs do |t|
      # t.index [:job_id, :staff_id]
      # t.index [:staff_id, :job_id]
    end
  end
end
