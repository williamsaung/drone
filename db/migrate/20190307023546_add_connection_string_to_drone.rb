class AddConnectionStringToDrone < ActiveRecord::Migration[5.2]
  def change
    add_column :drones, :connection_string, :string
  end
end
