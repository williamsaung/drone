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

ActiveRecord::Schema.define(version: 2019_04_08_111612) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "post_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "drone_availables", force: :cascade do |t|
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drones", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "connection_string"
    t.string "description"
    t.boolean "simulator"
    t.index ["user_id"], name: "index_drones_on_user_id"
  end

  create_table "forecasts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "lng"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.float "weight"
    t.bigint "drone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_id"
    t.string "status"
    t.integer "mission_id"
    t.bigint "user_id"
    t.string "type"
    t.index ["drone_id"], name: "index_missions_on_drone_id"
    t.index ["user_id"], name: "index_missions_on_user_id"
  end

  create_table "nav_logs", force: :cascade do |t|
    t.float "altitude"
    t.float "gps_latitude"
    t.float "gps_longitude"
    t.bigint "drone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "battery_voltage"
    t.integer "battery_level"
    t.float "battery_current"
    t.boolean "ekf_ok"
    t.boolean "is_armable"
    t.string "system_status"
    t.string "mode"
    t.boolean "armed"
    t.index ["drone_id"], name: "index_nav_logs_on_drone_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "status_logs", force: :cascade do |t|
    t.string "status"
    t.datetime "time"
    t.bigint "drone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drone_id"], name: "index_status_logs_on_drone_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.boolean "banned"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "drones", "users"
  add_foreign_key "missions", "drones"
  add_foreign_key "missions", "users"
  add_foreign_key "nav_logs", "drones"
  add_foreign_key "posts", "users"
  add_foreign_key "status_logs", "drones"
end
