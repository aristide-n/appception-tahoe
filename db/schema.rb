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

ActiveRecord::Schema.define(:version => 20130722054336) do

  create_table "environments", :force => true do |t|
    t.string   "user_agent"
    t.string   "platform"
    t.string   "device_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "selftests", :force => true do |t|
    t.string   "name"
    t.decimal  "k_ops"
    t.decimal  "ms_time"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "environment_id"
  end

  create_table "timelines", :force => true do |t|
    t.string   "test_name"
    t.text     "test_details"
    t.string   "json_file_name"
    t.text     "json_digest"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "device_name"
  end

end
