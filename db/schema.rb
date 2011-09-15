# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110915003730) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.string   "number"
    t.string   "complement"
    t.string   "neighborhood"
    t.string   "city"
    t.integer  "estate_id"
    t.string   "country"
    t.string   "cep",              :limit => 9
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "external_id"
    t.string   "table_rel"
    t.string   "description"
    t.integer  "level"
    t.string   "filename"
    t.string   "content_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "cnpj"
    t.string   "ie"
    t.string   "im"
    t.string   "sci"
    t.integer  "activity_id"
    t.string   "ind_com",             :limit => 1
    t.boolean  "active"
    t.string   "email_nfe"
    t.text     "observations"
    t.integer  "main_address_id"
    t.integer  "billing_address_id"
    t.integer  "delivery_address_id"
    t.integer  "old_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estates", :force => true do |t|
    t.string   "acronym"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hollydays", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day"
    t.integer  "month"
  end

  create_table "invoices", :force => true do |t|
    t.date     "operation"
    t.integer  "invoice_number"
    t.integer  "client_id"
    t.integer  "provider_id"
    t.integer  "seller_id"
    t.integer  "term_id"
    t.decimal  "ipi",              :precision => 9, :scale => 3
    t.decimal  "icms_base",        :precision => 9, :scale => 3
    t.decimal  "icms",             :precision => 9, :scale => 3
    t.decimal  "pis",              :precision => 9, :scale => 3
    t.decimal  "cofins",           :precision => 9, :scale => 3
    t.decimal  "products_value",   :precision => 9, :scale => 3
    t.decimal  "invoice_value",    :precision => 9, :scale => 3
    t.decimal  "commission_rate",  :precision => 9, :scale => 3
    t.integer  "activity_id"
    t.text     "observations"
    t.integer  "sell_id"
    t.integer  "parcels"
    t.integer  "natop_id"
    t.boolean  "delivery"
    t.decimal  "freight",          :precision => 9, :scale => 3
    t.decimal  "insurance",        :precision => 9, :scale => 3
    t.integer  "carrier_id"
    t.integer  "freight_type"
    t.boolean  "nfe"
    t.string   "nfe_received_key"
    t.string   "nfe_key"
    t.string   "nfe_protocol"
    t.integer  "nfe_env"
    t.decimal  "manaus_discount",  :precision => 9, :scale => 3
    t.boolean  "canceled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ncms", :force => true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "unit"
    t.integer  "ipi"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.integer  "external_id"
    t.string   "type"
    t.integer  "department_id"
    t.string   "email"
    t.integer  "function_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", :force => true do |t|
    t.integer  "person_id"
    t.string   "number"
    t.boolean  "main"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.string   "prod_cost",    :limit => 1
    t.integer  "address_id"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.boolean  "carrier"
    t.string   "ie"
    t.string   "cnpj"
    t.string   "bank"
    t.text     "observations"
    t.integer  "seller_id"
    t.integer  "invoicer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receivables", :force => true do |t|
    t.integer  "invoice_number"
    t.integer  "parcel"
    t.date     "due_date"
    t.decimal  "value",             :precision => 9, :scale => 3
    t.integer  "bank_id"
    t.string   "email"
    t.integer  "deposit_id"
    t.date     "payment_date"
    t.string   "collection_number"
    t.decimal  "daily_penalty",     :precision => 9, :scale => 3
    t.text     "observations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.text     "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
