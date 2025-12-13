class AddNameToVessel < ActiveRecord::Migration[8.0]
  def up
    add_column :vessels, :name, :string, null: false
  end
  def down
    remove_column :vessels, :name, :string
  end
end
