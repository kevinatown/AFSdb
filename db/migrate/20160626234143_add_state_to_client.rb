class AddStateToClient < ActiveRecord::Migration
  def change
    add_reference :clients, :state, index: true
  end
end
