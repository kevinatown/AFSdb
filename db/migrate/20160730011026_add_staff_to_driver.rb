class AddStaffToDriver < ActiveRecord::Migration
  def change
    add_reference :drivers, :staff, index: true
  end
end
