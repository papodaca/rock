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

ActiveRecord::Schema.define(version: 20130313232536) do

  create_table "albums", force: true do |t|
    t.string   "name"
    t.integer  "art_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", force: true do |t|
    t.string   "name"
    t.integer  "art_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arts", force: true do |t|
    t.integer  "data_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", force: true do |t|
    t.string   "path"
    t.integer  "media_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", force: true do |t|
    t.string   "name"
    t.integer  "progress"
    t.integer  "data_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_types", force: true do |t|
    t.string   "mime_type"
    t.string   "extension"
    t.boolean  "audio"
    t.boolean  "image"
    t.boolean  "feed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlist_elements", force: true do |t|
    t.integer  "order"
    t.integer  "playlist_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "podcast_episodes", force: true do |t|
    t.integer  "podcast_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "podcasts", force: true do |t|
    t.string   "name"
    t.integer  "data_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_key"], name: "index_sessions_on_session_key", using: :btree

  create_table "songs", force: true do |t|
    t.string   "title"
    t.integer  "track"
    t.integer  "disk"
    t.integer  "length"
    t.integer  "album_id"
    t.integer  "genre_id"
    t.integer  "artist_id"
    t.integer  "data_file_id"
    t.integer  "library_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_podcast_episodes", force: true do |t|
    t.integer  "location"
    t.boolean  "played"
    t.integer  "user_id"
    t.integer  "podcast_eposode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_podcast_subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "podcast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
