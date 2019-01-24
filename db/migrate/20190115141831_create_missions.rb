class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.string :name
      t.string :location
      t.float :weight
      t.references :drone, foreign_key: true

      t.timestamps
    end
  end
end
