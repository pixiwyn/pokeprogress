namespace :pokeapi do
  desc "Sync pokemon data from PokeAPI"
  task sync: :environment do
    puts "Starting sync..."

    region = 1
    generation = 1

    gen = PokeapiService.get_generation(generation)
    puts gen["main_region"]
    puts gen["pokemon_species"]

    gen_record = Generation.find_or_create_by!(pokeapi_id: gen["id"]) do |g|
      g.name = gen["name"]
    end

    reg_record = Region.find_or_create_by!(pokeapi_id: region) do |r|
      r.name = gen["main_region"]["name"].capitalize
    end

    gen["pokemon_species"].each do |species|
      pokemon = PokeapiService.get_pokemon(species["url"].split("/").compact_blank.last)
      puts pokemon["name"]
      pokemon_record = Pokemon.find_or_initialize_by(pokeapi_id: pokemon["id"])
      pokemon_record.name = pokemon["name"]
      pokemon_record.pokedex_number = pokemon["order"]
      pokemon_record.region = reg_record
      pokemon_record.generation = gen_record
      pokemon_record.thumbnail = pokemon["sprites"]["other"]["official-artwork"]["front_default"]
      pokemon_record.save!
    end

    puts "Done!"
  end
end
