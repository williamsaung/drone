class AddLatToForecasts < ActiveRecord::Migration[5.2]
  def change
    add_column :forecasts, :lat, :float
    add_column :forecasts, :lng, :float
  end
end
