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

ActiveRecord::Schema.define(version: 20160919001053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athlete_stories", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_athlete_stories_on_user_id", using: :btree
  end

  create_table "buckets", force: :cascade do |t|
    t.integer  "grade_system_id", null: false
    t.string   "name",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["grade_system_id"], name: "index_buckets_on_grade_system_id", using: :btree
  end

  create_table "climb_logs", force: :cascade do |t|
    t.integer  "athlete_story_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "climb_id",         null: false
    t.index ["athlete_story_id"], name: "index_climb_logs_on_athlete_story_id", using: :btree
    t.index ["climb_id"], name: "index_climb_logs_on_climb_id", using: :btree
  end

  create_table "climbs", force: :cascade do |t|
    t.integer  "color"
    t.string   "type",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "section_id",                  null: false
    t.integer  "grade_id",      default: 111, null: false
    t.datetime "teardown_date"
    t.index ["grade_id"], name: "index_climbs_on_grade_id", using: :btree
    t.index ["section_id"], name: "index_climbs_on_section_id", using: :btree
  end

  create_table "employments", force: :cascade do |t|
    t.integer  "gym_id",          null: false
    t.integer  "role_story_id",   null: false
    t.string   "role_story_type", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["gym_id"], name: "index_employments_on_gym_id", using: :btree
    t.index ["role_story_type", "role_story_id"], name: "index_employments_on_role_story_type_and_role_story_id", using: :btree
  end

  create_table "grade_systems", force: :cascade do |t|
    t.string   "name",                      null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "buckets_count", default: 0, null: false
  end

  create_table "grades", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "grade_system_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "sequence_number", null: false
    t.integer  "bucket_id"
    t.index ["bucket_id"], name: "index_grades_on_bucket_id", using: :btree
    t.index ["grade_system_id"], name: "index_grades_on_grade_system_id", using: :btree
  end

  create_table "gyms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "route_grade_system_id",   null: false
    t.integer  "boulder_grade_system_id", null: false
    t.index ["boulder_grade_system_id"], name: "index_gyms_on_boulder_grade_system_id", using: :btree
    t.index ["route_grade_system_id"], name: "index_gyms_on_route_grade_system_id", using: :btree
  end

  create_table "manager_stories", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_manager_stories_on_user_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "athlete_story_id"
    t.integer  "gym_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["athlete_story_id"], name: "index_memberships_on_athlete_story_id", using: :btree
    t.index ["gym_id"], name: "index_memberships_on_gym_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.integer  "gym_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gym_id"], name: "index_sections_on_gym_id", using: :btree
  end

  create_table "setter_stories", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_setter_stories_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "current_role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "athlete_stories", "users"
  add_foreign_key "buckets", "grade_systems"
  add_foreign_key "climb_logs", "athlete_stories"
  add_foreign_key "climb_logs", "climbs"
  add_foreign_key "climbs", "grades"
  add_foreign_key "climbs", "sections"
  add_foreign_key "employments", "gyms"
  add_foreign_key "grades", "buckets"
  add_foreign_key "grades", "grade_systems"
  add_foreign_key "gyms", "grade_systems", column: "boulder_grade_system_id"
  add_foreign_key "gyms", "grade_systems", column: "route_grade_system_id"
  add_foreign_key "manager_stories", "users"
  add_foreign_key "memberships", "athlete_stories"
  add_foreign_key "memberships", "gyms"
  add_foreign_key "sections", "gyms"
  add_foreign_key "setter_stories", "users"
end
