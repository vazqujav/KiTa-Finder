# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090414135117) do

  create_table "kitas", :force => true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "country_code"
    t.string   "geocoded_address"
    t.string   "phone"
    t.string   "url"
    t.text     "details"
    t.string   "age_from"
    t.string   "age_to"
    t.boolean  "is_active"
    t.boolean  "is_geocoded"
    t.string   "data_origin"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "no_kita_votes",    :default => 0
  end

end