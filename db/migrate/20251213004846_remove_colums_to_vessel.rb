class RemoveColumsToVessel < ActiveRecord::Migration[8.0]
  def up
    remove_column :vessels, :last_name, :string
    remove_column :vessels, :first_name, :string
    remove_column :vessels, :company_name, :string
    remove_column :vessels, :email, :string
    remove_column :vessels, :telephone, :string
  end

  def down
    add_column :vessels, :last_name, :string
    add_column :vessels, :first_name, :string
    add_column :vessels, :company_name, :string
    add_column :vessels, :email, :string
    add_column :vessels, :telephone, :string
  end
end
