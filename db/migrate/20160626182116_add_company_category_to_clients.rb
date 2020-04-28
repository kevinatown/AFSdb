class AddCompanyCategoryToClients < ActiveRecord::Migration
  def change
    add_reference :clients, :company_category, index: true
  end
end
