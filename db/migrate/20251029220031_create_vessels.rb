class CreateVessels < ActiveRecord::Migration[8.0]
  def up
    create_table :vessels do |t|
      t.string :registration_number
      t.string :operation_area
      t.string :last_name
      t.string :first_name
      t.string :company_name
      t.string :email
      t.string :telephone
      t.references :mmsi, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
  def down
    drop_table :vessels
  end
end
