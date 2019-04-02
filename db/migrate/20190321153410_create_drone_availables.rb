class CreateDroneAvailables < ActiveRecord::Migration[5.2]
  def change
    create_table :drone_availables do |t|
      t.boolean :status

      t.timestamps
    end
  end
end
