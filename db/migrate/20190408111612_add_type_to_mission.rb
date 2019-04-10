class AddTypeToMission < ActiveRecord::Migration[5.2]
  def change
    add_column :missions, :type, :string
  end
end
