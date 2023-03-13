class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.references :from_user, foreign_key: { to_table: :users }, null: false
      t.references :to_user, foreign_key: { to_table: :users }, null: false

      t.timestamps

      t.index %i[from_user_id to_user_id], unique: true
    end
  end
end
