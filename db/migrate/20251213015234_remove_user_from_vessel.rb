class RemoveUserFromVessel < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :vessels, :users
  end

  def down
    add_foreign_key :vessels, :users, :string
  end
end
