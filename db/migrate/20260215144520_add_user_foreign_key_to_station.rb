class AddUserForeignKeyToStation < ActiveRecord::Migration[8.0]
  def up
    add_foreign_key :stations, :users
  end
  def down
    remove_foreign_key :stations, :users
  end
end
