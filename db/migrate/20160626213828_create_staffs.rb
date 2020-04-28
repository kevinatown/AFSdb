class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :f_name
      t.string :m_name
      t.string :l_name
      t.text :skills
      t.text :limitations
      t.string :email
      t.string :phone
      t.string :street_number
      t.string :street_name
      t.string :suite
      t.string :city
      t.string :zip
      t.datetime :hire_date
      t.datetime :termination_date
      t.datetime :position
      t.text :notes
      t.decimal :hourly_wage
      t.decimal :annual_salary
      t.boolean :is_admin, default: false

      t.timestamps null: false
    end
  end
end
