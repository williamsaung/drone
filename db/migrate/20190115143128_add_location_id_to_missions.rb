class AddLocationIdToMissions < ActiveRecord::Migration[5.2]
  def change
    add_column :missions, :location_id, :integer
  end
end
