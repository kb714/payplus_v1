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

ActiveRecord::Schema.define(version: 20161222032830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buttons", force: :cascade do |t|
    t.integer  "shop_id"
    t.string   "name"
    t.string   "button_slug"
    t.text     "description"
    t.text     "retirement_address"
    t.string   "qr"
    t.integer  "price"
    t.integer  "charge"
    t.boolean  "is_stock",           default: false
    t.integer  "stock"
    t.boolean  "home_delivery"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "shops", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "secret_key"
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url"
    t.string   "notify_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "shop_id"
    t.integer  "status",                   default: 0
    t.string   "type"
    t.string   "service",                  default: "webpayplus"
    t.integer  "order"
    t.integer  "amount"
    t.string   "client_name"
    t.string   "client_last_name"
    t.string   "client_id"
    t.string   "client_email"
    t.string   "client_phone"
    t.string   "product_name"
    t.text     "product_description"
    t.text     "product_shipping_address"
    t.string   "id_session"
    t.string   "url_return"
    t.string   "url_final"
    t.string   "token"
    t.string   "url_webpay"
    t.string   "webpay_error"
    t.string   "accounting_date"
    t.string   "buy_order"
    t.string   "card_number"
    t.float    "webpay_amount"
    t.string   "commerce_code"
    t.string   "authorization_code"
    t.string   "payment_type_code"
    t.string   "response_code"
    t.string   "transaction_date"
    t.string   "url_redirection"
    t.string   "vci"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
