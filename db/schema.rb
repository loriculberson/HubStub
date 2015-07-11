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

ActiveRecord::Schema.define(version: 20150711220735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.text     "type"
    t.text     "street"
    t.text     "city"
    t.text     "state"
    t.text     "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "display_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.date     "date"
    t.boolean  "approved"
    t.integer  "image_id"
    t.integer  "venue_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.integer  "category_id"
    t.time     "start_time"
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree
  add_index "events", ["image_id"], name: "index_events_on_image_id", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                                                                         null: false
    t.datetime "updated_at",                                                                         null: false
    t.string   "photo",       default: "https://literaryyard.files.wordpress.com/2015/01/crowd.jpg"
  end

  create_table "item_categories", force: :cascade do |t|
    t.integer "item_id"
    t.integer "category_id"
  end

  create_table "item_orders", force: :cascade do |t|
    t.integer  "quantity",   default: 1
    t.integer  "item_id"
    t.integer  "order_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "item_orders", ["item_id"], name: "index_item_orders_on_item_id", using: :btree
  add_index "item_orders", ["order_id"], name: "index_item_orders_on_order_id", using: :btree

  create_table "item_statuses", force: :cascade do |t|
    t.string "state"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "unit_price"
    t.boolean  "pending",         default: false
    t.datetime "created_at",                                                                                null: false
    t.datetime "updated_at",                                                                                null: false
    t.boolean  "sold",            default: false
    t.string   "section"
    t.string   "row"
    t.string   "seat"
    t.string   "delivery_method"
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "ticket",          default: "http://www.urartuuniversity.com/content_images/pdf-sample.pdf"
  end

  add_index "items", ["event_id"], name: "index_items_on_event_id", using: :btree
  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "status",      default: "Ordered"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "total_price"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string "state"
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "display_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.boolean  "suspended"
  end

  create_table "vendors", force: :cascade do |t|
    t.text     "name"
    t.integer  "user_id"
    t.text     "description"
    t.text     "slug"
    t.text     "credit_card"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "lat"
    t.float    "long"
    t.integer  "time_zone_offset"
  end

  add_foreign_key "events", "categories"
  add_foreign_key "events", "images"
  add_foreign_key "events", "venues"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
end
