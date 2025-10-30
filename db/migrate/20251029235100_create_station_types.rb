class CreateStationTypes < ActiveRecord::Migration[8.0]
  def up
    create_table :station_types do |t|
      t.string :category

      t.timestamps
    end
  end

  def down
    drop_table :station_types
  end
end
