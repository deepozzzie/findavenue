# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_06_012015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.string "venue_name"
    t.string "venue_capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "lat"
    t.string "lng"
    t.string "phone_number"
    t.string "link"
    t.string "capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.float "percentage_full"
    t.boolean "is_active", default: false
    t.string "places_id"
    t.string "rating"
    t.boolean "is_open"
    t.integer "update_number", default: 0
    t.integer "monday_open"
    t.integer "monday_closed"
    t.integer "tuesday_open"
    t.integer "tuesday_closed"
    t.integer "wednesday_open"
    t.integer "wednesday_closed"
    t.integer "thursday_open"
    t.integer "thursday_closed"
    t.integer "friday_open"
    t.integer "friday_closed"
    t.integer "saturday_open"
    t.integer "saturday_closed"
    t.integer "sunday_open"
    t.integer "sunday_closed"
  end

  create_table "indices", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "patrons", force: :cascade do |t|
    t.string "first_name"
    t.string "phone_number"
    t.boolean "waitlist", default: true
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_patrons_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_venues_on_company_id"
  end

  add_foreign_key "patrons", "companies"
  add_foreign_key "users", "companies"
  add_foreign_key "venues", "companies"
end
