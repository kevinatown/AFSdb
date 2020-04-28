class CreateHeatTypes < ActiveRecord::Migration
  def change
    create_table :heat_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
