class AddEventTypeToCalendar < ActiveRecord::Migration
  def change
    add_reference :calendars, :event_type, index: true
  end
end
