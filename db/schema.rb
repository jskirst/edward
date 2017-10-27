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

ActiveRecord::Schema.define(version: 20171027213104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "api_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string "name"
    t.string "input_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "characters"
    t.string "text_field_type"
    t.string "mask"
    t.integer "workflow_id"
    t.text "default_value"
    t.string "token"
    t.string "prefix"
    t.string "suffix"
    t.index ["workflow_id", "name"], name: "index_answers_on_workflow_id_and_name", unique: true
  end

  create_table "answers_options", force: :cascade do |t|
    t.integer "answer_id"
    t.integer "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.string "value"
    t.string "text"
    t.integer "workflow_id"
    t.string "token"
    t.integer "duplicated_from_id"
  end

  create_table "steps", force: :cascade do |t|
    t.text "text"
    t.text "conditions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "callout"
    t.integer "workflow_id"
    t.string "callout_method"
    t.string "callout_body"
    t.string "cta"
    t.string "token"
    t.string "cta_class"
    t.text "cta_href"
    t.index ["text", "conditions", "workflow_id"], name: "index_steps_on_text_and_conditions_and_workflow_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "workflows", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.string "name"
    t.index ["token"], name: "index_workflows_on_token", unique: true
  end

end
