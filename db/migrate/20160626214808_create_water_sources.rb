class CreateWaterSources < ActiveRecord::Migration
  def change
    create_table :water_sources do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
