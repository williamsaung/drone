class CreateStatusLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :status_logs do |t|
      t.string :status
      t.datetime :time
      t.references :drone, foreign_key: true

      t.timestamps
    end
  end
end
