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

ActiveRecord::Schema[8.0].define(version: 2025_07_08_065259) do
  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "slug"
    t.string "thumbnail_url"
    t.integer "duration"
    t.integer "min_score", default: 0
    t.boolean "is_randomize", default: false
    t.boolean "is_active", default: true
    t.integer "user_id"
    t.bigint "parent_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_mandatory", default: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "email_verified_at"
  end
end
