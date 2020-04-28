class CreateAfsAccounts < ActiveRecord::Migration
  def change
    create_table :afs_accounts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
