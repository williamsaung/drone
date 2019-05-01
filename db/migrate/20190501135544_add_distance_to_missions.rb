class AddDistanceToMissions < ActiveRecord::Migration[5.2]
  def change
    add_column :missions, :distance, :float
  end
end
