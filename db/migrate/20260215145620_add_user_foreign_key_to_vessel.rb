class AddUserForeignKeyToVessel < ActiveRecord::Migration[8.0]
  def up
    add_foreign_key :vessels, :users
  end
  def down
    remove_foreign_key :vessels, :users, :string
  end
end
