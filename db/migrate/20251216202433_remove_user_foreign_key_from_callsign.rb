class RemoveUserForeignKeyFromCallsign < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :callsigns, :users
  end

  def down
    add_foreign_key :callsigns, :users
  end
end
