class CreateContractorCategories < ActiveRecord::Migration
  def change
    create_table :contractor_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
