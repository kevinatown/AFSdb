class AddStaffToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :staff, index: true
  end
end
