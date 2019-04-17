class ChangeStuffFromNavLogs < ActiveRecord::Migration[5.2]
  def change
    change_column :nav_logs, :armed, :string
    change_column :nav_logs, :is_armable, :string
    change_column :nav_logs, :ekf_ok, :string
  end
end
