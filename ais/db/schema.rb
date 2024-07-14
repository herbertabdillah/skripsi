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

ActiveRecord::Schema.define(version: 2024_01_03_032905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_configs", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blockchain_sync_batches", force: :cascade do |t|
    t.string "status"
    t.string "description"
    t.string "sync_result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blockchain_syncs", force: :cascade do |t|
    t.string "syncable_type"
    t.bigint "syncable_id"
    t.string "status"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "blockchain_sync_batch_id"
    t.index ["blockchain_sync_batch_id"], name: "index_blockchain_syncs_on_blockchain_sync_batch_id"
  end

  create_table "course_plan_course_semesters", force: :cascade do |t|
    t.bigint "course_plan_id", null: false
    t.bigint "course_semester_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_plan_id"], name: "index_course_plan_course_semesters_on_course_plan_id"
    t.index ["course_semester_id"], name: "index_course_plan_course_semesters_on_course_semester_id"
  end

  create_table "course_plans", force: :cascade do |t|
    t.integer "year"
    t.integer "semester"
    t.bigint "student_id", null: false
    t.boolean "is_approved"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_course_plans_on_student_id"
  end

  create_table "course_result_scores", force: :cascade do |t|
    t.bigint "course_result_id", null: false
    t.bigint "course_plan_course_semester_id", null: false
    t.decimal "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_plan_course_semester_id"], name: "index_course_result_scores_on_course_plan_course_semester_id"
    t.index ["course_result_id"], name: "index_course_result_scores_on_course_result_id"
  end

  create_table "course_results", force: :cascade do |t|
    t.bigint "course_plan_id", null: false
    t.decimal "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_plan_id"], name: "index_course_results_on_course_plan_id"
  end

  create_table "course_semesters", force: :cascade do |t|
    t.integer "year"
    t.integer "semester"
    t.bigint "course_id", null: false
    t.bigint "lecturer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_semesters_on_course_id"
    t.index ["lecturer_id"], name: "index_course_semesters_on_lecturer_id"
  end

  create_table "course_years", force: :cascade do |t|
    t.integer "year"
    t.string "semester"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.bigint "department_id", null: false
    t.string "kind"
    t.integer "credit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.bigint "faculty_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "graduates", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.decimal "score"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_graduates_on_student_id"
  end

  create_table "lecturers", force: :cascade do |t|
    t.string "name"
    t.string "nik"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "nim"
    t.bigint "department_id", null: false
    t.integer "entry_year"
    t.string "status"
    t.bigint "supervisor_lecturer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_students_on_department_id"
    t.index ["supervisor_lecturer_id"], name: "index_students_on_supervisor_lecturer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "userable_type"
    t.bigint "userable_id"
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["userable_type", "userable_id"], name: "index_users_on_userable"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.json "object"
    t.json "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "course_plan_course_semesters", "course_plans"
  add_foreign_key "course_plan_course_semesters", "course_semesters"
  add_foreign_key "course_plans", "students"
  add_foreign_key "course_result_scores", "course_plan_course_semesters"
  add_foreign_key "course_result_scores", "course_results"
  add_foreign_key "course_results", "course_plans"
  add_foreign_key "course_semesters", "courses"
  add_foreign_key "course_semesters", "lecturers"
  add_foreign_key "courses", "departments"
  add_foreign_key "departments", "faculties"
  add_foreign_key "graduates", "students"
  add_foreign_key "students", "departments"
  add_foreign_key "students", "lecturers", column: "supervisor_lecturer_id"
end
