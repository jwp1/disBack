# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160418142639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_ideas", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "idea_id"
    t.integer  "round"
    t.integer  "votes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "player_id"
    t.boolean  "winner"
  end

  add_index "active_ideas", ["game_id"], name: "index_active_ideas_on_game_id", using: :btree
  add_index "active_ideas", ["idea_id"], name: "index_active_ideas_on_idea_id", using: :btree
  add_index "active_ideas", ["player_id"], name: "index_active_ideas_on_player_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.integer  "rounds"
    t.integer  "input_timer"
    t.integer  "battle_timer"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "current_round"
    t.integer  "player_count"
    t.boolean  "voting_over"
    t.boolean  "game_over"
    t.boolean  "submitting_over"
    t.boolean  "started"
  end

  create_table "ideas", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "popularity",  default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "points"
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "name"
    t.integer  "round"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["game_id"], name: "index_questions_on_game_id", using: :btree

  create_table "uber_ideas", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "strength"
    t.integer  "votes"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "winner"
  end

  add_index "uber_ideas", ["game_id"], name: "index_uber_ideas_on_game_id", using: :btree
  add_index "uber_ideas", ["player_id"], name: "index_uber_ideas_on_player_id", using: :btree

  add_foreign_key "active_ideas", "players"
  add_foreign_key "players", "games"
  add_foreign_key "questions", "games"
  add_foreign_key "uber_ideas", "games"
  add_foreign_key "uber_ideas", "players"
end
