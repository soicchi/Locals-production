class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :comment
      t.string :restaurant_name, null: false
      t.string :station, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
