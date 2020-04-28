class AddClientToJob < ActiveRecord::Migration
  def change
    add_reference :jobs, :client, index: true
  end
end
