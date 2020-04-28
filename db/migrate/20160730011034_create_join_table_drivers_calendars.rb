class CreateJoinTableDriversCalendars < ActiveRecord::Migration
  def change
    create_join_table :drivers, :calendars do |t|
      # t.index [:driver_id, :calendar_id]
      # t.index [:calendar_id, :driver_id]
    end
  end
end
