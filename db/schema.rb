ActiveRecord::Schema.define(version: 2021_10_03_124347) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline"
    t.string "status"
    t.integer "priority"
    t.bigint "user_id"
    t.index ["name"], name: "index_tasks_on_name"
    t.index ["status"], name: "index_tasks_on_status"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "tasks", "users"
end
