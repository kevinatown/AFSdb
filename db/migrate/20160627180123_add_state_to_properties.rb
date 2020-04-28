class AddStateToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :state, index: true
  end
end
