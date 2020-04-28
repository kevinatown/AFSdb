class AddStreetTypeToContractor < ActiveRecord::Migration
  def change
    add_reference :contractors, :street_type, index: true
  end
end
