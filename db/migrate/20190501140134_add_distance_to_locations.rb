class AddDistanceToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :distance, :float
  end
end
