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

ActiveRecord::Schema.define(version: 20160617065545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pairs", force: :cascade do |t|
    t.integer  "class_number"
    t.integer  "pair_set"
    t.integer  "first_id"
    t.integer  "second_id"
    t.string   "first_full_name"
    t.string   "second_full_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "class_number"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
