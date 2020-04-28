class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :f_name
      t.string :l_name
      t.string :phone
      t.string :email
      t.string :title
      t.string :extension

      t.timestamps null: false
    end
  end
end
