class CreateCallsigns < ActiveRecord::Migration[8.0]
  def up
    create_table :callsigns do |t|
      t.string :call_sign_num, null: false
      t.references :mmsi, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
  def down
    drop_table :callsigns
  end
end
