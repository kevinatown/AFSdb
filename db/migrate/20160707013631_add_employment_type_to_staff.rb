class AddEmploymentTypeToStaff < ActiveRecord::Migration
  def change
    add_reference :staffs, :employment_type, index: true
  end
end
