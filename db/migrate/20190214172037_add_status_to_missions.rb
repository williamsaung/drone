class AddStatusToMissions < ActiveRecord::Migration[5.2]
  def change
    add_column :missions, :status, :string
  end
end
