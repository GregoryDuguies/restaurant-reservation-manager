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

ActiveRecord::Schema[7.1].define(version: 2024_03_08_193418) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservation_tables", force: :cascade do |t|
    t.bigint "reservation_id"
    t.bigint "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_reservation_tables_on_reservation_id"
    t.index ["table_id"], name: "index_reservation_tables_on_table_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "table_id"
    t.bigint "restaurant_id"
    t.string "owner_name"
    t.string "owner_phone_number"
    t.datetime "start_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "total_guests"
    t.datetime "end_datetime"
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
    t.index ["table_id"], name: "index_reservations_on_table_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.bigint "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "capacity"
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

end
