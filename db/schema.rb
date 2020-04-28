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

ActiveRecord::Schema.define(version: 20180111025044) do

  create_table "account_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "afs_accounts", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "account_type_id", limit: 4
  end

  add_index "afs_accounts", ["account_type_id"], name: "index_afs_accounts_on_account_type_id", using: :btree

  create_table "building_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "calendars", force: :cascade do |t|
    t.datetime "event_start"
    t.datetime "event_finish"
    t.text     "description",   limit: 65535
    t.text     "notes",         limit: 65535
    t.string   "location",      limit: 255
    t.boolean  "allday"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "event_type_id", limit: 4
    t.integer  "job_id",        limit: 4
  end

  add_index "calendars", ["event_type_id"], name: "index_calendars_on_event_type_id", using: :btree
  add_index "calendars", ["job_id"], name: "index_calendars_on_job_id", using: :btree

  create_table "calendars_cars", id: false, force: :cascade do |t|
    t.integer "car_id",      limit: 4, null: false
    t.integer "calendar_id", limit: 4, null: false
  end

  create_table "calendars_contractors", id: false, force: :cascade do |t|
    t.integer "contractor_id", limit: 4, null: false
    t.integer "calendar_id",   limit: 4, null: false
  end

  create_table "calendars_drivers", id: false, force: :cascade do |t|
    t.integer "driver_id",   limit: 4, null: false
    t.integer "calendar_id", limit: 4, null: false
  end

  create_table "calendars_staffs", id: false, force: :cascade do |t|
    t.integer "staff_id",    limit: 4, null: false
    t.integer "calendar_id", limit: 4, null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer  "model_year", limit: 4
    t.string   "make",       limit: 255
    t.string   "model",      limit: 255
    t.string   "color",      limit: 255
    t.string   "nickname",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "address",             limit: 255
    t.string   "city",                limit: 255
    t.string   "zip",                 limit: 255
    t.string   "phone",               limit: 255
    t.string   "fax",                 limit: 255
    t.string   "email",               limit: 255
    t.string   "website",             limit: 255
    t.text     "notes",               limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "company_category_id", limit: 4
    t.integer  "state_id",            limit: 4
  end

  add_index "clients", ["company_category_id"], name: "index_clients_on_company_category_id", using: :btree
  add_index "clients", ["state_id"], name: "index_clients_on_state_id", using: :btree

  create_table "company_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "f_name",     limit: 255
    t.string   "l_name",     limit: 255
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.string   "title",      limit: 255
    t.string   "extension",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "client_id",  limit: 4
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id", using: :btree

  create_table "contractor_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contractors", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "address",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "zip",                    limit: 255
    t.string   "phone",                  limit: 255
    t.string   "fax",                    limit: 255
    t.string   "email",                  limit: 255
    t.string   "website",                limit: 255
    t.text     "notes",                  limit: 65535
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "contractor_category_id", limit: 4
    t.integer  "state_id",               limit: 4
    t.integer  "street_type_id",         limit: 4
  end

  add_index "contractors", ["contractor_category_id"], name: "index_contractors_on_contractor_category_id", using: :btree
  add_index "contractors", ["state_id"], name: "index_contractors_on_state_id", using: :btree
  add_index "contractors", ["street_type_id"], name: "index_contractors_on_street_type_id", using: :btree

  create_table "counties", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "driver_lic_num", limit: 255
    t.datetime "driver_lic_exp"
    t.text     "notes",          limit: 65535
    t.integer  "staff_id",       limit: 4
    t.integer  "state_id",       limit: 4
  end

  add_index "drivers", ["staff_id"], name: "index_drivers_on_staff_id", using: :btree
  add_index "drivers", ["state_id"], name: "index_drivers_on_state_id", using: :btree

  create_table "employment_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "expense_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.datetime "date_incurred"
    t.string   "vendor_name",     limit: 255
    t.string   "vendor_location", limit: 255
    t.string   "description",     limit: 255
    t.decimal  "amount",                        precision: 8, scale: 2
    t.text     "notes",           limit: 65535
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "expense_type_id", limit: 4
    t.integer  "staff_id",        limit: 4
    t.integer  "afs_account_id",  limit: 4
    t.integer  "job_id",          limit: 4
  end

  add_index "expenses", ["afs_account_id"], name: "index_expenses_on_afs_account_id", using: :btree
  add_index "expenses", ["expense_type_id"], name: "index_expenses_on_expense_type_id", using: :btree
  add_index "expenses", ["job_id"], name: "index_expenses_on_job_id", using: :btree
  add_index "expenses", ["staff_id"], name: "index_expenses_on_staff_id", using: :btree

  create_table "heat_fuels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "heat_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "job_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "job_subcategories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.datetime "date_approved"
    t.datetime "date_assigned"
    t.datetime "date_due"
    t.text     "tasks",                    limit: 65535
    t.datetime "date_completed"
    t.decimal  "afs_price",                              precision: 8, scale: 2
    t.decimal  "contractor_price",                       precision: 8, scale: 2
    t.decimal  "wages_paid",                             precision: 8, scale: 2
    t.decimal  "materials_cost",                         precision: 8, scale: 2
    t.decimal  "misc_cost",                              precision: 8, scale: 2
    t.datetime "date_invoiced"
    t.datetime "anticipated_payment_date"
    t.datetime "date_payment_recv"
    t.decimal  "payment",                                precision: 8, scale: 2
    t.string   "client_check_number",      limit: 255
    t.boolean  "is_closed",                                                      default: false
    t.text     "notes_for_office_staff",   limit: 65535
    t.text     "notes_for_field_staff",    limit: 65535
    t.text     "notes_for_client",         limit: 65535
    t.boolean  "carrington_property",                                            default: false
    t.datetime "created_at",                                                                     null: false
    t.datetime "updated_at",                                                                     null: false
    t.integer  "client_id",                limit: 4
    t.integer  "job_category_id",          limit: 4
    t.integer  "job_subcategory_id",       limit: 4
    t.integer  "property_id",              limit: 4
    t.integer  "contact_id",               limit: 4
    t.integer  "contractor_id",            limit: 4
    t.integer  "status",                   limit: 4
  end

  add_index "jobs", ["client_id"], name: "index_jobs_on_client_id", using: :btree
  add_index "jobs", ["contact_id"], name: "index_jobs_on_contact_id", using: :btree
  add_index "jobs", ["contractor_id"], name: "index_jobs_on_contractor_id", using: :btree
  add_index "jobs", ["job_category_id"], name: "index_jobs_on_job_category_id", using: :btree
  add_index "jobs", ["job_subcategory_id"], name: "index_jobs_on_job_subcategory_id", using: :btree
  add_index "jobs", ["property_id"], name: "index_jobs_on_property_id", using: :btree

  create_table "jobs_staffs", id: false, force: :cascade do |t|
    t.integer "job_id",   limit: 4, null: false
    t.integer "staff_id", limit: 4, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "street_number",   limit: 255
    t.string   "street_name",     limit: 255
    t.string   "suite",           limit: 255
    t.string   "city",            limit: 255
    t.string   "zip",             limit: 255
    t.integer  "bldg_sqr_feet",   limit: 4
    t.integer  "lot_sqr_feet",    limit: 4
    t.decimal  "lot_acreage",                   precision: 10
    t.integer  "year_built",      limit: 4
    t.text     "notes",           limit: 65535
    t.string   "lockbox_code",    limit: 255
    t.boolean  "is_closed",                                    default: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "heat_type_id",    limit: 4
    t.integer  "heat_fuel_id",    limit: 4
    t.integer  "state_id",        limit: 4
    t.integer  "street_type_id",  limit: 4
    t.integer  "water_source_id", limit: 4
    t.integer  "waste_system_id", limit: 4
    t.integer  "streetdir_id",    limit: 4
    t.boolean  "cps_property"
    t.string   "cps_client",      limit: 255
    t.string   "cps_program",     limit: 255
  end

  add_index "properties", ["heat_fuel_id"], name: "index_properties_on_heat_fuel_id", using: :btree
  add_index "properties", ["heat_type_id"], name: "index_properties_on_heat_type_id", using: :btree
  add_index "properties", ["state_id"], name: "index_properties_on_state_id", using: :btree
  add_index "properties", ["street_type_id"], name: "index_properties_on_street_type_id", using: :btree
  add_index "properties", ["streetdir_id"], name: "index_properties_on_streetdir_id", using: :btree
  add_index "properties", ["waste_system_id"], name: "index_properties_on_waste_system_id", using: :btree
  add_index "properties", ["water_source_id"], name: "index_properties_on_water_source_id", using: :btree

  create_table "staffs", force: :cascade do |t|
    t.string   "f_name",             limit: 255
    t.string   "m_name",             limit: 255
    t.string   "l_name",             limit: 255
    t.text     "skills",             limit: 65535
    t.text     "limitations",        limit: 65535
    t.string   "email",              limit: 255
    t.string   "phone",              limit: 255
    t.string   "street_number",      limit: 255
    t.string   "street_name",        limit: 255
    t.string   "suite",              limit: 255
    t.string   "city",               limit: 255
    t.string   "zip",                limit: 255
    t.datetime "hire_date"
    t.datetime "termination_date"
    t.datetime "position"
    t.text     "notes",              limit: 65535
    t.decimal  "hourly_wage",                      precision: 10, scale: 2
    t.decimal  "annual_salary",                    precision: 10, scale: 2
    t.boolean  "is_admin",                                                  default: false
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.integer  "state_id",           limit: 4
    t.integer  "street_type_id",     limit: 4
    t.integer  "employment_type_id", limit: 4
    t.integer  "streetdir_id",       limit: 4
  end

  add_index "staffs", ["employment_type_id"], name: "index_staffs_on_employment_type_id", using: :btree
  add_index "staffs", ["state_id"], name: "index_staffs_on_state_id", using: :btree
  add_index "staffs", ["street_type_id"], name: "index_staffs_on_street_type_id", using: :btree
  add_index "staffs", ["streetdir_id"], name: "index_staffs_on_streetdir_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "street_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "streetdirs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "time_clocks", force: :cascade do |t|
    t.datetime "time_in"
    t.datetime "time_out"
    t.float    "lat_in",     limit: 24
    t.float    "long_in",    limit: 24
    t.float    "lat_out",    limit: 24
    t.float    "long_out",   limit: 24
    t.text     "notes",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "staff_id",   limit: 4
    t.integer  "job_id",     limit: 4
  end

  add_index "time_clocks", ["job_id"], name: "index_time_clocks_on_job_id", using: :btree
  add_index "time_clocks", ["staff_id"], name: "index_time_clocks_on_staff_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "staff_id",               limit: 4
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["staff_id"], name: "index_users_on_staff_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "waste_systems", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "water_sources", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
