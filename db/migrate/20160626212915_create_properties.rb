class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :street_number
      t.string :street_name
      t.string :suite
      t.string :city
      t.string :zip
      t.integer :bldg_sqr_feet
      t.integer :lot_sqr_feet
      t.decimal :lot_acreage
      t.integer :year_built
      t.text :notes
      t.string :lockbox_code
      t.boolean :is_closed, default: false

      t.timestamps null: false
    end
  end
end
