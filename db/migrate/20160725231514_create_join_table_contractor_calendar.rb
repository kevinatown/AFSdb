class CreateJoinTableContractorCalendar < ActiveRecord::Migration
  def change
    create_join_table :contractors, :calendars do |t|
      # t.index [:contractor_id, :calendar_id]
      # t.index [:calendar_id, :contractor_id]
    end
  end
end
