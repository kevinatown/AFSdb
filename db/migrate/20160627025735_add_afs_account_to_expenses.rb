class AddAfsAccountToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :afs_account, index: true
  end
end
