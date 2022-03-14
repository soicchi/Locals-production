class CreateTastes < ActiveRecord::Migration[6.1]
  def change
    create_table :tastes do |t|
      t.string :content, null: false

      t.timestamps
    end
  end
end
