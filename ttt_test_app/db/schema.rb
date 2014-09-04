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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140904152452) do

  create_table "games", :force => true do |t|
    t.integer  "player_1_id"
    t.integer  "player_2_id"
    t.string   "outcome"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "grid_size"
    t.integer  "winner_id"
  end

  create_table "moves", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "position"
    t.string   "marker"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "moves", ["game_id"], :name => "index_moves_on_game_id"
  add_index "moves", ["user_id"], :name => "index_moves_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
  end

end
