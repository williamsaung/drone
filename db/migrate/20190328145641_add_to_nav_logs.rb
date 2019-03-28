class AddToNavLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :nav_logs, :battery_level, :integer
    add_column :nav_logs, :battery_current, :float
    add_column :nav_logs, :ekf_ok, :boolean
    add_column :nav_logs, :is_armable, :boolean
    add_column :nav_logs, :system_status, :string
    add_column :nav_logs, :mode, :string
    add_column :nav_logs, :armed, :boolean
  end
end
