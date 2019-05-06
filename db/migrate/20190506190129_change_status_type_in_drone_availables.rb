class ChangeStatusTypeInDroneAvailables < ActiveRecord::Migration[5.2]
  def self.up
    change_column :drone_availables, :status, :string
  end

  def self.down
    change_column :drone_availables, :status, :boolean
  end
end
