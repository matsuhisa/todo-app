ActiveRecord::Schema.define(version: 20180613045409) do

  create_table "completion_dates", force: :cascade do |t|
    t.integer "task_id", null: false
    t.datetime "begin_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_completion_dates_on_task_id"
  end

  create_table "task_due_dates", force: :cascade do |t|
    t.integer "task_id", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_due_dates_on_task_id"
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "user_id", null: false
    t.integer "team_id", null: false
    t.integer "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_tasks_on_team_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "team_due_dates", force: :cascade do |t|
    t.integer "team_id", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_due_dates_on_team_id"
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_teams", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_user_teams_on_team_id"
    t.index ["user_id", "team_id"], name: "index_user_teams_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_user_teams_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
