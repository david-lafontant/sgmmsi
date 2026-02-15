class RemoveUserForeignKeyFromMmsis < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :mmsis, :users
  end
  def down
    add_foreign_key :mmsis, :users
  end
end
