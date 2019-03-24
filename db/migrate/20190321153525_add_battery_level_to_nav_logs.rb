class AddBatteryLevelToNavLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :nav_logs, :battery_level, :float
  end
end
