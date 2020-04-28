class AddJobToExpenses < ActiveRecord::Migration
  def change
  	add_reference :expenses, :job, index: true
  end
end
