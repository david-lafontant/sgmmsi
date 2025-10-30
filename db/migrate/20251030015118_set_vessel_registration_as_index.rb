class SetVesselRegistrationAsIndex < ActiveRecord::Migration[8.0]
  def up
    add_index :vessels, :registration_number, unique: true
  end

  def down
    remove_index :vessels, :registration_number, unique: true
  end
end
