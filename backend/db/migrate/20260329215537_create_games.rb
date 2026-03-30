class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.string :name
      t.references :region, null: false, foreign_key: true
      t.references :generation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
