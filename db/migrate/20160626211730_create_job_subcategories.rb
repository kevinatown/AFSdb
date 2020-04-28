class CreateJobSubcategories < ActiveRecord::Migration
  def change
    create_table :job_subcategories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
