# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_27_053429) do

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "star_id"
    t.index ["follower_id", "star_id"], name: "index_follows_on_follower_id_and_star_id", unique: true
  end

  create_table "friends", force: :cascade do |t|
    t.integer "freind1_id"
    t.integer "freind2_id"
    t.boolean "status1", default: false
    t.boolean "status2", default: false
  end

  create_table "my_stocks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "stock_id"
    t.integer "privacy", default: 1
    t.index ["stock_id", "user_id"], name: "index_my_stocks_on_stock_id_and_user_id", unique: true
  end

  create_table "stock_prices", force: :cascade do |t|
    t.string "Name"
    t.float "price"
    t.date "date"
    t.integer "stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "Name"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
