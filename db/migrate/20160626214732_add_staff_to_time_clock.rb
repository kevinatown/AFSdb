class AddStaffToTimeClock < ActiveRecord::Migration
  def change
    add_reference :time_clocks, :staff, index: true
  end
end
