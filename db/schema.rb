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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120330030205) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",    :default => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classrooms", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "zone_id"
    t.boolean  "goes_here"
    t.boolean  "receives_people_here"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professorships", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "activity_id"
    t.integer  "price_per_hour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "teacher_id"
    t.integer  "rating"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "description"
    t.string   "email"
    t.string   "cellphone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "email"
    t.string   "cellphone"
    t.string   "description"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",   :default => false
  end

end
