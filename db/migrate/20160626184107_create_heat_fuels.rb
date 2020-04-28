class CreateHeatFuels < ActiveRecord::Migration
  def change
    create_table :heat_fuels do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
