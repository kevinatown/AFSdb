class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :driver_lic_num
      t.datetime :driver_lic_exp
      t.text :notes
    end
  end
end
