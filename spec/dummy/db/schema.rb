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

ActiveRecord::Schema.define(version: 20160323083802) do

  create_table "books", force: :cascade do |t|
    t.string   "title",                               null: false
    t.text     "description"
    t.decimal  "price",       precision: 9, scale: 2, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "books", ["title"], name: "index_books_on_title"

  create_table "cart_of_fun_addresses", force: :cascade do |t|
    t.string   "firstname",     null: false
    t.string   "lastname",      null: false
    t.string   "address",       null: false
    t.integer  "zipcode",       null: false
    t.string   "city",          null: false
    t.string   "phone",         null: false
    t.string   "type",          null: false
    t.integer  "country_id"
    t.integer  "order_id"
    t.integer  "customer_id"
    t.string   "customer_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "cart_of_fun_countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_of_fun_coupons", force: :cascade do |t|
    t.integer  "code"
    t.float    "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_of_fun_credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "cvv"
    t.string   "expiration_month"
    t.string   "expiration_year"
    t.integer  "customer_id"
    t.string   "customer_type"
    t.integer  "order_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "cart_of_fun_deliveries", force: :cascade do |t|
    t.string   "title",                              null: false
    t.decimal  "price",      precision: 5, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "cart_of_fun_order_items", force: :cascade do |t|
    t.decimal  "price",        precision: 9, scale: 2, null: false
    t.integer  "quantity",                             null: false
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "order_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "cart_of_fun_order_items", ["order_id"], name: "index_cart_of_fun_order_items_on_order_id"

  create_table "cart_of_fun_orders", force: :cascade do |t|
    t.decimal  "total_price",    precision: 9, scale: 2, null: false
    t.datetime "completed_date",                         null: false
    t.integer  "customer_id"
    t.string   "customer_type"
    t.integer  "delivery_id"
    t.string   "state"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "puzzles", force: :cascade do |t|
    t.string   "title",                               null: false
    t.text     "description"
    t.decimal  "price",       precision: 9, scale: 2, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "puzzles", ["title"], name: "index_puzzles_on_title"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
