class AddContractorCategoryToContractors < ActiveRecord::Migration
  def change
    add_reference :contractors, :contractor_category, index: true
  end
end
