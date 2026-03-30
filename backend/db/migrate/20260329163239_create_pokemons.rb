class CreatePokemons < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemons do |t|
      t.string :thumbnail
      t.string :name
      t.string :pokeapi_id
      t.references :region, null: false, foreign_key: true
      t.references :generation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
