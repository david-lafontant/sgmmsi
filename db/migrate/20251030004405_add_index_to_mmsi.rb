class AddIndexToMmsi < ActiveRecord::Migration[8.0]
  def up
    add_index :mmsis, :mmsi_id, unique: true
  end

  def down
    remove_index :mmsis, :mmsi_id, unique: true
  end
end
