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

ActiveRecord::Schema[8.0].define(version: 2025_07_10_120305) do
  create_table "answers", force: :cascade do |t|
    t.integer "exam_id", null: false
    t.integer "submission_id", null: false
    t.string "option_key"
    t.boolean "is_answered", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_answers_on_exam_id"
    t.index ["submission_id"], name: "index_answers_on_submission_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "slug"
    t.string "thumbnail_url"
    t.integer "duration", default: 0
    t.integer "min_score", default: 0
    t.boolean "is_randomize", default: false
    t.boolean "is_active", default: true
    t.integer "user_id"
    t.bigint "parent_id", default: 0
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_mandatory", default: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "question_text"
    t.text "body"
    t.integer "course_id", null: false
    t.text "options", default: "[]"
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_exams_on_course_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "user_id", null: false
    t.datetime "started_at"
    t.boolean "is_completed", default: false
    t.datetime "submitted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_submissions_on_course_id"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "email_verified_at"
  end

  add_foreign_key "answers", "exams"
  add_foreign_key "answers", "submissions"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "exams", "courses"
  add_foreign_key "submissions", "courses"
  add_foreign_key "submissions", "users"
end
