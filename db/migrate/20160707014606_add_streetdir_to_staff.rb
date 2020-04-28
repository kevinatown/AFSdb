class AddStreetdirToStaff < ActiveRecord::Migration
  def change
    add_reference :staffs, :streetdir, index: true
  end
end
