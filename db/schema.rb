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

ActiveRecord::Schema.define(version: 20151231180050) do

  create_table "backpacks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "size"
    t.string   "brand"
  end

  create_table "glasses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "brand"
    t.boolean  "sunglasses"
  end

  create_table "images", force: :cascade do |t|
    t.integer  "lost_object_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["lost_object_id"], name: "index_images_on_lost_object_id"

  create_table "laptops", force: :cascade do |t|
    t.string   "brand"
    t.string   "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "size"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["parent_id"], name: "index_locations_on_parent_id"

  create_table "lost_objects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.boolean  "state"
    t.date     "date_added"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "location_id"
    t.integer  "actable_id"
    t.string   "actable_type"
  end

  create_table "notebooks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "size"
    t.string   "type"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "brand"
    t.string   "model"
    t.string   "company"
    t.boolean  "case"
    t.boolean  "cracked_screen"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.text     "message"
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.integer  "incidence_type"
    t.text     "message"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "lost_object_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.date     "opened_at"
    t.boolean  "new_entry"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "gender"
    t.integer  "age"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "verified",          default: false
    t.string   "perishable_token"
    t.integer  "role",              default: 0
    t.boolean  "blocked"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
