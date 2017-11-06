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

ActiveRecord::Schema.define(version: 20171106152323) do

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["real_estate_id"], name: "index_likes_on_real_estate_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "real_estate_id"
    t.index [nil], name: "index_real_estates_on_picture_id_id"
  end

  create_table "real_estates", force: :cascade do |t|
    t.text "description"
    t.decimal "price"
    t.decimal "lat"
    t.decimal "lon"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.index ["user_id"], name: "index_real_estates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
