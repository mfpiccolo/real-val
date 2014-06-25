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

ActiveRecord::Schema.define(version: 20140624230414) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "properties", force: true do |t|
    t.string   "address"
    t.integer  "units"
    t.integer  "listing_price_cents",     default: 0,     null: false
    t.string   "listing_price_currency",  default: "USD", null: false
    t.integer  "rent_per_month_cents",    default: 0,     null: false
    t.string   "rent_per_month_currency", default: "USD", null: false
    t.float    "tecr"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sqr_ft"
    t.float    "price_per_sqr_ft"
    t.integer  "hoa_fee_cents",           default: 0,     null: false
    t.string   "hoa_fee_currency",        default: "USD", null: false
  end

end
