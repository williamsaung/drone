class CreateMissionRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :mission_records do |t|
      t.float :latitude
      t.float :longitude
      t.references :drone, foreign_key: true

      t.timestamps
    end
  end
end
