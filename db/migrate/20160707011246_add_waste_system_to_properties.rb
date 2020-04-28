class AddWasteSystemToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :waste_system, index: true
  end
end
