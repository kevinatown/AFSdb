class AddExpenseTypeToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :expense_type, index: true
  end
end
