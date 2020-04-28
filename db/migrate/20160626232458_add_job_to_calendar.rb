class AddJobToCalendar < ActiveRecord::Migration
  def change
    add_reference :calendars, :job, index: true
  end
end
