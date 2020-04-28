class AddStreetTypeToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :street_type, index: true
  end
end
