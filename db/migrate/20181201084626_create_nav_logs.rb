class CreateNavLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :nav_logs do |t|
      t.float :altitude
      t.float :gps_latitude
      t.float :gps_longitude
      t.datetime :log_datetime
      t.references :drone, foreign_key: true

      t.timestamps
    end
  end
end
