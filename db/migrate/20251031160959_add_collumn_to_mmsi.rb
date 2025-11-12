class AddCollumnToMmsi < ActiveRecord::Migration[8.0]
  def up
    add_column :mmsis, :status, :boolean, null: false, default: false
  end

  def down
    remove_column :mmsis, :status, :boolean
  end
end
