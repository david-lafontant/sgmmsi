class CreateStations < ActiveRecord::Migration[8.0]
  def up
    create_table :stations do |t|
      t.string :registration_number
      t.decimal :latitude
      t.decimal :longitude
      t.string :municipality
      t.references :station_type, null: false, foreign_key: true
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
    drop_table :stations
  end
end
