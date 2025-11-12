class AddCategoryToMmsi < ActiveRecord::Migration[8.0]
  def up
    add_column :mmsis, :category, :string, null: false, default: "vessel"
  end

  def down
    remove_column :mmsis, :category, :string
  end
end
