class ChangeTypeFromMission < ActiveRecord::Migration[5.2]
  def change
    rename_column :missions, :type, :mission_type
  end
end
