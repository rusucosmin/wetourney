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

ActiveRecord::Schema.define(version: 2019_08_16_220507) do

  create_table "contestants", force: :cascade do |t|
    t.string "name"
    t.integer "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_contestants_on_tournament_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer "contestant_one_id"
    t.integer "contestant_two_id"
    t.integer "winner_id"
    t.integer "round_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contestant_one_id"], name: "index_matches_on_contestant_one_id"
    t.index ["contestant_two_id"], name: "index_matches_on_contestant_two_id"
    t.index ["round_id"], name: "index_matches_on_round_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "tournament_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
