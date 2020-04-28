class AddStaffToUser < ActiveRecord::Migration
  def change
    add_reference :users, :staff, index: true
  end
end
