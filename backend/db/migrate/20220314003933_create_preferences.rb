class CreatePreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :taste, null: false, foreign_key: true

      t.timestamps
    end
    add_index :preferences, [:user_id, :taste_id], unique: true
  end
end
