class CreateCompanyCategories < ActiveRecord::Migration
  def change
    create_table :company_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
