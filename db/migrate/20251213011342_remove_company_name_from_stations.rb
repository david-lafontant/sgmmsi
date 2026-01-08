class RemoveCompanyNameFromStations < ActiveRecord::Migration[8.0]
  def up
    remove_column :stations, :company_name, :string
  end

  def down
    add_column :stations, :company_name, :string
  end
end
