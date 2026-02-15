class AddUserForeignKeyToMmsi < ActiveRecord::Migration[8.0]
  def up
    add_foreign_key :mmsis, :users
  end
  def down
    remove_foreign_key :mmsis, :users
  end
end
