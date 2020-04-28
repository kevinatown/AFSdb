class AddContractorToJob < ActiveRecord::Migration
  def change
    add_reference :jobs, :contractor, index: true
  end
end
