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

ActiveRecord::Schema.define(version: 20160216171256) do

  create_table "artists", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "artists", ["name"], name: "index_artists_on_name", unique: true

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id",           null: false
    t.string   "bookmarkable_type", null: false
    t.integer  "bookmarkable_id",   null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "bookmarks", ["bookmarkable_id"], name: "index_bookmarks_on_bookmarkable_id"
  add_index "bookmarks", ["bookmarkable_type"], name: "index_bookmarks_on_bookmarkable_type"
  add_index "bookmarks", ["user_id", "bookmarkable_type", "bookmarkable_id"], name: "index_bookmarks_on_user_id_and_bookmarkable_type_and_id", unique: true
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id"

  create_table "followings", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "followed_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "followings", ["followed_id"], name: "index_followings_on_followed_id"
  add_index "followings", ["follower_id", "followed_id"], name: "index_followings_on_follower_id_and_followed_id", unique: true
  add_index "followings", ["follower_id"], name: "index_followings_on_follower_id"

  create_table "playlist_selections", force: :cascade do |t|
    t.integer  "song_id",     null: false
    t.integer  "playlist_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "playlist_selections", ["playlist_id"], name: "index_playlist_selections_on_playlist_id"
  add_index "playlist_selections", ["song_id"], name: "index_playlist_selections_on_song_id"

  create_table "playlists", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "playlists", ["name"], name: "index_playlists_on_name"
  add_index "playlists", ["user_id", "name"], name: "index_playlists_on_user_id_and_name", unique: true
  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id"

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id"
  add_index "songs", ["name", "artist_id"], name: "index_songs_on_name_and_artist_id", unique: true
  add_index "songs", ["name"], name: "index_songs_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_token"
    t.string   "password_digest"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["first_name"], name: "index_users_on_first_name"
  add_index "users", ["last_name"], name: "index_users_on_last_name"

end
