class CreateJoinTableCarCalendar < ActiveRecord::Migration
  def change
    create_join_table :cars, :calendars do |t|
      # t.index [:car_id, :calendar_id]
      # t.index [:calendar_id, :car_id]
    end
  end
end
