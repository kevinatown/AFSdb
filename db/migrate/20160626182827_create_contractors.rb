class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :zip
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website
      t.text :notes

      t.timestamps null: false
    end
  end
end
