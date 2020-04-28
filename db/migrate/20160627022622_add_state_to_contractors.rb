class AddStateToContractors < ActiveRecord::Migration
  def change
    add_reference :contractors, :state, index: true
  end
end
