# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_30_003046) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "game_progresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.jsonb "metadata"
    t.bigint "pokemon_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["game_id"], name: "index_game_progresses_on_game_id"
    t.index ["pokemon_id"], name: "index_game_progresses_on_pokemon_id"
    t.index ["user_id"], name: "index_game_progresses_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.bigint "generation_id", null: false
    t.string "name"
    t.bigint "region_id", null: false
    t.string "short_name"
    t.datetime "updated_at", null: false
    t.index ["generation_id"], name: "index_games_on_generation_id"
    t.index ["region_id"], name: "index_games_on_region_id"
  end

  create_table "generations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "pokeapi_id"
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "generation_id", null: false
    t.string "name"
    t.string "pokeapi_id"
    t.integer "pokedex_number"
    t.bigint "region_id", null: false
    t.string "thumbnail"
    t.datetime "updated_at", null: false
    t.index ["generation_id"], name: "index_pokemons_on_generation_id"
    t.index ["region_id"], name: "index_pokemons_on_region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "pokeapi_id"
    t.datetime "updated_at", null: false
  end

  create_table "user_games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "game_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["game_id"], name: "index_user_games_on_game_id"
    t.index ["user_id"], name: "index_user_games_on_user_id"
  end

  create_table "user_pokemons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "note"
    t.bigint "pokemon_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["pokemon_id"], name: "index_user_pokemons_on_pokemon_id"
    t.index ["user_id"], name: "index_user_pokemons_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "game_progresses", "games"
  add_foreign_key "game_progresses", "pokemons"
  add_foreign_key "game_progresses", "users"
  add_foreign_key "games", "generations"
  add_foreign_key "games", "regions"
  add_foreign_key "pokemons", "generations"
  add_foreign_key "pokemons", "regions"
  add_foreign_key "user_games", "games"
  add_foreign_key "user_games", "users"
  add_foreign_key "user_pokemons", "pokemons"
  add_foreign_key "user_pokemons", "users"
end
