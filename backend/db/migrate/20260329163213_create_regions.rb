class CreateRegions < ActiveRecord::Migration[8.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :pokeapi_id

      t.timestamps
    end
  end
end
