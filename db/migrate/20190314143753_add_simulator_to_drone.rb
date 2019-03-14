class AddSimulatorToDrone < ActiveRecord::Migration[5.2]
  def change
    add_column :drones, :simulator, :boolean
  end
end
