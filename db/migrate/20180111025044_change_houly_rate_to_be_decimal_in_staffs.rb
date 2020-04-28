class ChangeHoulyRateToBeDecimalInStaffs < ActiveRecord::Migration
  def change
  	change_column :staffs, :hourly_wage, :decimal, precision: 10, scale: 2
  	change_column :staffs, :annual_salary, :decimal, precision: 10, scale: 2
  end
end
