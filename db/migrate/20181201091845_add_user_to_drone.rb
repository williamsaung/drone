class AddUserToDrone < ActiveRecord::Migration[5.2]
  def change
    add_reference :drones, :user, foreign_key: true
  end
end
