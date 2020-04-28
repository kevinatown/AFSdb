class AddHeatTypeToProperties < ActiveRecord::Migration
  def change
   add_reference :properties, :heat_type, index: true
  end
end
