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

ActiveRecord::Schema.define(version: 20150215051107) do

  create_table "games", force: :cascade do |t|
    t.string   "state",             default: "---\n1:\n- a1\n- a2\n- a3\n- a4\n- a5\n- a6\n2:\n- b1\n- b2\n- b3\n- b4\n- b5\n- b6\n3:\n- c1\n- c2\n- c3\n- c4\n- c5\n- c6\n4:\n- d1\n- d2\n- d3\n- d4\n- d5\n- d6\n5:\n- e1\n- e2\n- e3\n- e4\n- e5\n- e6\n6:\n- f1\n- f2\n- f3\n- f4\n- f5\n- f6\n7:\n- g1\n- g2\n- g3\n- g4\n- g5\n- g6\n"
    t.integer  "current_player_id"
    t.datetime "created_at",                                                                                                                                                                                                                                                                                                                  null: false
    t.datetime "updated_at",                                                                                                                                                                                                                                                                                                                  null: false
    t.integer  "winner_id"
    t.boolean  "finished",          default: false,                                                                                                                                                                                                                                                                                           null: false
    t.integer  "players_count"
    t.integer  "turn_count",        default: 42
  end

  create_table "players", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "bitcoin_address"
    t.string   "card_type"
    t.datetime "expirey_date"
    t.string   "card_number_last_four"
    t.string   "favorite_color"
    t.string   "blog"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "ties"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
