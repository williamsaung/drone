class AddDescriptionToDrone < ActiveRecord::Migration[5.2]
  def change
    add_column :drones, :description, :string
  end
end
