class SetStationRegistrationAsIndex < ActiveRecord::Migration[8.0]
  def up
    add_index :stations, :registration_number, unique: true
  end

  def down
    remove_index :stations, :registration_number, unique: true
  end
end
