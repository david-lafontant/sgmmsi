class RemoveStatusFromCallsign < ActiveRecord::Migration[8.0]
  def up
    remove_column :callsigns, :status, :string
  end

  def down
    add_column :callsigns, :status, :string
  end
end
