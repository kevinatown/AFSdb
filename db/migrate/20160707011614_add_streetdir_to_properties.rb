class AddStreetdirToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :streetdir, index: true
  end
end
