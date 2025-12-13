class AddIndexToNameToVessel < ActiveRecord::Migration[8.0]
  def up
    add_index :vessels, :name, unique: true
  end

  def down
    remove_index :vessels, :name
  end
end
