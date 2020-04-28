class AddStreetTypeToStaff < ActiveRecord::Migration
  def change
    add_reference :staffs, :street_type, index: true
  end
end
