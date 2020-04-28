class CreateWasteSystems < ActiveRecord::Migration
  def change
    create_table :waste_systems do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
