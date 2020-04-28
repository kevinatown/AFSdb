class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.datetime :event_start
      t.datetime :event_finish
      t.text :description
      t.text :notes
      t.string :location
      t.boolean :allday

      t.timestamps null: false
    end
  end
end
