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

ActiveRecord::Schema.define(version: 20160304120206) do

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

  create_table "countries_users", id: false, force: :cascade do |t|
    t.integer "user_id",    null: false
    t.integer "country_id", null: false
  end

  add_index "countries_users", ["country_id", "user_id"], name: "index_countries_users_on_country_id_and_user_id", using: :btree
  add_index "countries_users", ["user_id", "country_id"], name: "index_countries_users_on_user_id_and_country_id", using: :btree

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

  create_table "likes", force: :cascade do |t|
    t.integer  "liker_id"
    t.integer  "liked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["liked_id"], name: "index_likes_on_liked_id", using: :btree
  add_index "likes", ["liker_id", "liked_id"], name: "index_likes_on_liker_id_and_liked_id", unique: true, using: :btree
  add_index "likes", ["liker_id"], name: "index_likes_on_liker_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "original_post_id"
  end

  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "reply_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "name"
    t.string   "salt"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree

  add_foreign_key "posts", "users"
  add_foreign_key "users", "cities"
end
