# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150109224138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prediction_results", force: true do |t|
    t.datetime "month"
    t.float    "maximum"
    t.float    "minimum"
    t.float    "upper_quartile"
    t.float    "lower_quartile"
    t.float    "median"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "currently_running", default: false
  end

  create_table "project_backlog_months", force: true do |t|
    t.datetime "month"
    t.float    "percent_complete"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "stage"
    t.string   "client"
    t.string   "code"
    t.float    "gross_contract"
    t.string   "title"
    t.string   "project_type"
    t.boolean  "rfp"
    t.boolean  "new_client"
    t.integer  "pipeline_owner_id"
    t.float    "other_revenue"
    t.float    "consulting_revenue"
    t.date     "identified_on"
    t.date     "submitted_on"
    t.date     "authorized_on"
    t.date     "lost_on"
    t.text     "comments"
    t.float    "probability"
    t.date     "start_on"
    t.integer  "months"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "backlog_owner_id"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
