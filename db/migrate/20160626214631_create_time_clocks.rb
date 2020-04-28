class CreateTimeClocks < ActiveRecord::Migration
  def change
    create_table :time_clocks do |t|
      t.datetime :time_in
      t.datetime :time_out
      t.float :lat_in
      t.float :long_in
      t.float :lat_out
      t.float :long_out
      t.text :notes

      t.timestamps null: false
    end
  end
end
