class AddCpsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :cps_property, :boolean
    add_column :properties, :cps_client, :string
    add_column :properties, :cps_program, :string
  end
end
