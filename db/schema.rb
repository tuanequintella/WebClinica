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

ActiveRecord::Schema.define(:version => 20130305213517) do

  create_table "agendas", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "default_meeting_length"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.boolean  "active"
  end

  create_table "appointments", :force => true do |t|
    t.integer  "agenda_id"
    t.datetime "date_time"
    t.integer  "record_id"
  end

  create_table "available_days", :force => true do |t|
    t.integer  "agenda_id"
    t.integer  "day"
    t.datetime "work_start_time"
    t.datetime "work_end_time"
    t.datetime "interval_start_time"
    t.datetime "interval_end_time"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "contact_infos", :force => true do |t|
    t.integer  "reachable_id"
    t.string   "reachable_type"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pacients", :force => true do |t|
    t.string   "name"
    t.string   "cpf"
    t.string   "rg"
    t.date     "birthdate"
    t.string   "health_insurances"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "parent_name"
    t.string   "parent_rg"
    t.string   "parent_cpf"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "records", :force => true do |t|
    t.string   "record_id"
    t.string   "record_status"
    t.string   "description"
    t.integer  "pacient_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "name"
    t.string   "cpf"
    t.string   "rg"
    t.date     "birthdate"
    t.string   "type"
    t.string   "crm"
    t.date     "gradyear"
    t.string   "occupation"
    t.decimal  "appointmentprice"
    t.string   "accepted_health_insurances"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
