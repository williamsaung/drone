class RemoveDistanceFromMissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :missions, :distance
  end
end
