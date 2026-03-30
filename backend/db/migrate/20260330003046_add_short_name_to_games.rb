class AddShortNameToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :short_name, :string
  end
end
