class AddClientToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :client, index: true
  end
end
