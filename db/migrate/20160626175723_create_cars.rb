class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :model_year
      t.string :make
      t.string :model
      t.string :color
      t.string :nickname

      t.timestamps null: false
    end
  end
end
