class AddHeatFuelToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :heat_fuel, index: true
  end
end
