class DropUptimesTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :uptimes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

