class AddBannedToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :banned, :boolean, default: false
  end

  def down
    remove_column :users, :banned, :boolean
  end
end
