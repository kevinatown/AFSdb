class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.datetime :date_approved
      t.datetime :date_assigned
      t.datetime :date_due
      t.text :tasks
      t.datetime :date_completed
      t.decimal :afs_price, :precision => 8, :scale => 2
      t.decimal :contractor_price, :precision => 8, :scale => 2
      t.decimal :wages_paid, :precision => 8, :scale => 2
      t.decimal :materials_cost, :precision => 8, :scale => 2
      t.decimal :misc_cost, :precision => 8, :scale => 2
      t.datetime :date_invoiced
      t.datetime :anticipated_payment_date
      t.datetime :date_payment_recv
      t.decimal :payment, :precision => 8, :scale => 2
      t.string :client_check_number
      t.boolean :is_closed, default: false
      t.text :notes_for_office_staff
      t.text :notes_for_field_staff
      t.text :notes_for_client
      t.boolean :carrington_property, default: false

      t.timestamps null: false
    end
  end
end
