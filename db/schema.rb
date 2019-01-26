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

ActiveRecord::Schema.define(version: 2019_01_23_093638) do

  create_table "floors", force: :cascade do |t|
    t.integer "number_of_spaces", null: false
    t.integer "garage_id"
    t.string "name"
    t.index ["garage_id"], name: "index_floors_on_garage_id"
  end

  create_table "garages", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "parking_transactions", force: :cascade do |t|
    t.integer "floor_id"
    t.boolean "active", default: true, null: false
    t.string "ticket", null: false
    t.index ["active", "ticket"], name: "index_parking_transactions_on_active_and_ticket", unique: true
    t.index ["floor_id"], name: "index_parking_transactions_on_floor_id"
  end

end
