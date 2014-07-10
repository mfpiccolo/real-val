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

ActiveRecord::Schema.define(version: 20140710081739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
    t.hstore   "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "messages",       default: [], array: true
  end

  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "properties", force: true do |t|
    t.string   "address"
    t.integer  "units"
    t.integer  "listing_price_cents",                                default: 0,     null: false
    t.string   "listing_price_currency",                             default: "USD", null: false
    t.integer  "rent_per_month_cents",                               default: 0,     null: false
    t.string   "rent_per_month_currency",                            default: "USD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sqr_ft"
    t.float    "price_per_sqr_ft"
    t.integer  "hoa_fee_cents",                                      default: 0,     null: false
    t.string   "hoa_fee_currency",                                   default: "USD", null: false
    t.integer  "user_id"
    t.string   "number"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "z_bedrooms"
    t.float    "z_bathrooms"
    t.integer  "z_tax_assessment_cents",                             default: 0,     null: false
    t.string   "z_tax_assessment_currency",                          default: "USD", null: false
    t.string   "z_tax_assessment_year"
    t.string   "z_year_built"
    t.date     "z_last_sold_on"
    t.integer  "z_last_sold_price_cents",                            default: 0,     null: false
    t.string   "z_last_sold_price_currency",                         default: "USD", null: false
    t.string   "z_lot_size_square_feet"
    t.string   "z_finished_square_feet"
    t.integer  "z_price_cents",                                      default: 0,     null: false
    t.string   "z_price_currency",                                   default: "USD", null: false
    t.integer  "z_price_high_cents",                                 default: 0,     null: false
    t.string   "z_price_high_currency",                              default: "USD", null: false
    t.integer  "z_price_low_cents",                                  default: 0,     null: false
    t.string   "z_price_low_currency",                               default: "USD", null: false
    t.integer  "z_price_change_cents",                               default: 0,     null: false
    t.string   "z_price_change_currency",                            default: "USD", null: false
    t.string   "z_price_change_duration"
    t.integer  "zpid"
    t.integer  "z_rent_cents",                                       default: 0,     null: false
    t.string   "z_rent_currency",                                    default: "USD", null: false
    t.integer  "z_rent_low_cents",                                   default: 0,     null: false
    t.string   "z_rent_low_currency",                                default: "USD", null: false
    t.integer  "z_rent_high_cents",                                  default: 0,     null: false
    t.string   "z_rent_high_currency",                               default: "USD", null: false
    t.date     "z_rent_updated_on"
    t.integer  "z_rent_change_cents",                                default: 0,     null: false
    t.string   "z_rent_change_currency",                             default: "USD", null: false
    t.string   "z_rent_change_duration"
    t.decimal  "tecr",                       precision: 6, scale: 4
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "ltv_1",                  default: 0.965
    t.float    "ltv_2",                  default: 0.8
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "user_name"
    t.text     "modifications"
    t.integer  "number"
    t.integer  "reverted_from"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["created_at"], name: "index_versions_on_created_at", using: :btree
  add_index "versions", ["number"], name: "index_versions_on_number", using: :btree
  add_index "versions", ["tag"], name: "index_versions_on_tag", using: :btree
  add_index "versions", ["user_id", "user_type"], name: "index_versions_on_user_id_and_user_type", using: :btree
  add_index "versions", ["user_name"], name: "index_versions_on_user_name", using: :btree
  add_index "versions", ["versioned_id", "versioned_type"], name: "index_versions_on_versioned_id_and_versioned_type", using: :btree

  create_table "zip_codes", force: true do |t|
    t.integer  "code"
    t.integer  "z_index_value_cents",    default: 0,     null: false
    t.string   "z_index_value_currency", default: "USD", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "area"
  end

end
