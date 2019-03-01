class RemoveLogDatetimeFromNavLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :nav_logs, :log_datetime, :datetime
  end
end
