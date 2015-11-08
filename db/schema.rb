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

ActiveRecord::Schema.define(version: 20151107223330) do

  create_table "meetings", force: :cascade do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.date     "date"
    t.text     "description"
    t.string   "venue"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title"
    t.time     "checkin_time"
    t.time     "checkout_time"
  end

  add_index "meetings", ["user_id"], name: "index_meetings_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visitors", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "visitors", ["user_id"], name: "index_visitors_on_user_id"

  create_table "visitors_meetings", force: :cascade do |t|
    t.integer  "visitor_id"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "visitors_meetings", ["meeting_id"], name: "index_visitors_meetings_on_meeting_id"
  add_index "visitors_meetings", ["visitor_id"], name: "index_visitors_meetings_on_visitor_id"

end
