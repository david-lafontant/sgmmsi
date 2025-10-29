class CreateMmsis < ActiveRecord::Migration[8.0]
  def up
    create_table :mmsis do |t|
      t.string :mmsi_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :mmsis
  end
end
