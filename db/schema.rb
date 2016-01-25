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

ActiveRecord::Schema.define(version: 20160125125515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "interest_id", null: false
  end

  add_index "interests_users", ["interest_id", "user_id"], name: "index_interests_users_on_interest_id_and_user_id", using: :btree
  add_index "interests_users", ["user_id", "interest_id"], name: "index_interests_users_on_user_id_and_interest_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "language_id", null: false
  end

  add_index "languages_users", ["language_id", "user_id"], name: "index_languages_users_on_language_id_and_user_id", using: :btree
  add_index "languages_users", ["user_id", "language_id"], name: "index_languages_users_on_user_id_and_language_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "gender",               default: 0
    t.string   "nationality"
    t.integer  "countries_want_to_go", default: [],                 array: true
    t.boolean  "willing_to_host",      default: false
    t.string   "password_digest"
    t.boolean  "confirmed",            default: false
    t.string   "confirm_token"
    t.string   "access_token"
    t.integer  "city_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.date     "birthday"
    t.boolean  "can_transport"
    t.text     "transport_detail"
    t.boolean  "can_tourguide"
    t.text     "tourguide_detail"
    t.boolean  "can_accomendation"
    t.text     "accomendation_detail"
    t.boolean  "can_pickup"
    t.text     "pickup_detail"
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree

  add_foreign_key "users", "cities"
end
