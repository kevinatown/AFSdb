class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.datetime :date_incurred
      t.string :vendor_name
      t.string :vendor_location
      t.string :description
      t.decimal :amount, :precision => 8, :scale => 2
      t.text :notes

      t.timestamps null: false
    end
  end
end
