class ChangeMmsiIdToMmsiNumberInMmsi < ActiveRecord::Migration[8.0]
  def up
    rename_column :mmsis, :mmsi_id, :mmsi_number
  end

  def down
    rename_column :mmsis, :mmsi_number, :mmsi_id
  end
end
