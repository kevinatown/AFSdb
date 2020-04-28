class AddStateToDrivers < ActiveRecord::Migration
  def change
    # add_column :drivers, :state_id, :integer
    add_reference :drivers, :state, index: true
  end
end
