class AddUserForeignKeyCallsign < ActiveRecord::Migration[8.0]
  def up
    add_foreign_key :callsigns, :users
  end
  def down
    remove_foreign_key :callsigns, :users, :string
  end
end
