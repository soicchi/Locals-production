class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.references :post, null: false, foreign_key: true
      t.references :taste, null: false, foreign_key: true

      t.timestamps
    end
    add_index :evaluations, [:post_id, :taste_id], unique: true
  end
end
