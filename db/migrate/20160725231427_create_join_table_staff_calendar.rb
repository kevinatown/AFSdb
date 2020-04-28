class CreateJoinTableStaffCalendar < ActiveRecord::Migration
  def change
    create_join_table :staffs, :calendars do |t|
      # t.index [:staff_id, :calendar_id]
      # t.index [:calendar_id, :staff_id]
    end
  end
end
