class AddWaterSourceToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :water_source, index: true
  end
end
