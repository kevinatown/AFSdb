class AddAccountTypeToAfsAccounts < ActiveRecord::Migration
  def change
    add_reference :afs_accounts, :account_type, index: true  
  end
end
