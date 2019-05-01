class AddLockVersionToDrones < ActiveRecord::Migration[5.2]
  def change
    add_column :drones, :lock_version, :integer, default: 0, null: false
  end
end
