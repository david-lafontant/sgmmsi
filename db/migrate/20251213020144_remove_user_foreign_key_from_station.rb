class RemoveUserForeignKeyFromStation < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :stations, :users
  end
  def down
    remove_foreign_key :stations, :users
  end
end
