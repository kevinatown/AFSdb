class CreateStreetdirs < ActiveRecord::Migration
  def change
    create_table :streetdirs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
