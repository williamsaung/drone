class ChangeBatteryLevel < ActiveRecord::Migration[5.2]
  def change
    rename_column :nav_logs, :battery_level, :battery_voltage
  end
end
