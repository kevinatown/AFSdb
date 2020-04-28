class AddStateToStaff < ActiveRecord::Migration
  def change
    add_reference :staffs, :state, index: true
  end
end
