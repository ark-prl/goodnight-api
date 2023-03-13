class CreateSleeps < ActiveRecord::Migration[7.0]
  def change
    create_table :sleeps do |t|
      t.references :user, null: false
      t.date :date, null: false
      t.datetime :clockin_at
      t.datetime :clockout_at
      t.integer :duration

      t.timestamps
    end
  end
end
