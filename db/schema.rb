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

ActiveRecord::Schema.define(:version => 20120726164705) do

  create_table "VwCashFlow", :id => false, :force => true do |t|
    t.date    "date"
    t.decimal "rec",   :precision => 65, :scale => 3
    t.decimal "recd",  :precision => 54, :scale => 2
    t.decimal "pay",   :precision => 65, :scale => 3
    t.decimal "payd",  :precision => 54, :scale => 2
    t.decimal "total", :precision => 65, :scale => 3
  end

  create_table "VwCashFlowPayables", :id => false, :force => true do |t|
    t.date    "date"
    t.decimal "rec",  :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "recd", :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "pay",  :precision => 56, :scale => 3
    t.decimal "payd", :precision => 3,  :scale => 2, :default => 0.0, :null => false
  end

  create_table "VwCashFlowPayablesPre", :id => false, :force => true do |t|
    t.integer "id",                                      :default => 0, :null => false
    t.date    "due_date"
    t.decimal "payable",  :precision => 34, :scale => 3
  end

  create_table "VwCashFlowPayd", :id => false, :force => true do |t|
    t.date    "date"
    t.decimal "rec",  :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "recd", :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "pay",  :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "payd", :precision => 32, :scale => 2
  end

  create_table "VwCashFlowReceivables", :id => false, :force => true do |t|
    t.date    "date"
    t.decimal "rec",  :precision => 56, :scale => 3
    t.decimal "recd", :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "pay",  :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "payd", :precision => 3,  :scale => 2, :default => 0.0, :null => false
  end

  create_table "VwCashFlowReceivablesPre", :id => false, :force => true do |t|
    t.integer "id",                                        :default => 0, :null => false
    t.date    "issue_date"
    t.decimal "payable",    :precision => 34, :scale => 3
  end

  create_table "VwCashFlowReceived", :id => false, :force => true do |t|
    t.date    "date"
    t.decimal "rec",  :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "recd", :precision => 32, :scale => 2
    t.decimal "pay",  :precision => 3,  :scale => 2, :default => 0.0, :null => false
    t.decimal "payd", :precision => 3,  :scale => 2, :default => 0.0, :null => false
  end

  create_table "VwCashFlowUnion", :id => false, :force => true do |t|
    t.date    "date"
    t.decimal "rec",  :precision => 56, :scale => 3
    t.decimal "recd", :precision => 32, :scale => 2
    t.decimal "pay",  :precision => 56, :scale => 3
    t.decimal "payd", :precision => 32, :scale => 2
  end

  create_table "account_plans", :force => true do |t|
    t.string   "name",       :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.string   "street",           :limit => 100
    t.string   "number",           :limit => 20
    t.string   "complement",       :limit => 40
    t.string   "neighborhood",     :limit => 50
    t.string   "city",             :limit => 70
    t.integer  "estate_id"
    t.string   "country",          :limit => 70
    t.string   "cep",              :limit => 9
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  create_table "apportionments", :force => true do |t|
    t.integer  "account_plan_id"
    t.integer  "cost_center_id"
    t.string   "cost_center_name"
    t.decimal  "rate",             :precision => 10, :scale => 4
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

  create_table "bank_account_transactions", :force => true do |t|
    t.integer  "bank_account_id"
    t.string   "name"
    t.string   "historic"
    t.decimal  "debit",           :precision => 9, :scale => 3
    t.decimal  "credit",          :precision => 9, :scale => 3
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_accounts", :force => true do |t|
    t.string   "contact"
    t.string   "bank_name"
    t.string   "phone"
    t.string   "fax"
    t.string   "email_cob"
    t.string   "email_ger"
    t.integer  "address_id"
    t.string   "manager"
    t.string   "manager_cel"
    t.string   "agency_number"
    t.string   "account_number"
    t.text     "observations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carriers", :force => true do |t|
    t.string   "name",       :limit => 70
    t.string   "nickname",   :limit => 50
    t.string   "cnpj",       :limit => 18
    t.string   "ie",         :limit => 15
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars", :force => true do |t|
    t.integer  "carrier_id"
    t.string   "license_plate", :limit => 8
    t.integer  "estate_id"
    t.string   "brand",         :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cfops", :force => true do |t|
    t.integer  "number",                   :null => false
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string  "estate_acronym", :limit => 2
    t.integer "ibge_cod"
    t.string  "name",           :limit => 40
  end

  create_table "clients", :force => true do |t|
    t.string   "name",                :limit => 150
    t.string   "nickname",            :limit => 80
    t.string   "cnpj",                :limit => 20
    t.string   "ie",                  :limit => 20
    t.string   "im",                  :limit => 20
    t.string   "sci",                 :limit => 70
    t.integer  "activity_id"
    t.string   "ind_com",             :limit => 1
    t.boolean  "active"
    t.string   "email_nfe",           :limit => 70
    t.text     "observations"
    t.integer  "main_address_id"
    t.integer  "billing_address_id"
    t.integer  "delivery_address_id"
    t.integer  "old_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",                :limit => 20
    t.string   "cpf",                 :limit => 20
  end

  create_table "contracts", :force => true do |t|
    t.integer  "father_id"
    t.boolean  "rubric"
    t.integer  "order"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_type_id"
  end

  create_table "cost_centers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "csts", :force => true do |t|
    t.string  "code",        :limit => 2
    t.string  "description", :limit => 50
    t.string  "type"
    t.decimal "value",                     :precision => 10, :scale => 4
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enterprises", :force => true do |t|
    t.string   "name",              :limit => 70
    t.string   "cnpj",              :limit => 18
    t.string   "ie",                :limit => 15
    t.string   "nickname",          :limit => 50
    t.integer  "address_id"
    t.string   "phone",             :limit => 30
    t.integer  "danfe_orientation"
    t.integer  "nfe_ambient"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "estates", :force => true do |t|
    t.string   "acronym",    :limit => 2
    t.string   "name",       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ibge_cod"
    t.decimal  "aliq_icms",                :precision => 9, :scale => 3, :default => 0.0, :null => false
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

  create_table "invoice_items", :force => true do |t|
    t.integer  "invoice_id"
    t.integer  "product_id"
    t.string   "product_cod",     :limit => 20
    t.string   "product_name",    :limit => 60
    t.decimal  "quantity",                      :precision => 9,  :scale => 3
    t.integer  "measure_unit_id"
    t.integer  "parts"
    t.decimal  "unit_value",                    :precision => 9,  :scale => 3
    t.decimal  "total_value",                   :precision => 9,  :scale => 3
    t.decimal  "icm",                           :precision => 9,  :scale => 3
    t.decimal  "ipi",                           :precision => 9,  :scale => 3
    t.decimal  "pis",                           :precision => 9,  :scale => 3
    t.decimal  "cofins",                        :precision => 9,  :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "aliq_icm",                      :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "icm_base",                      :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "aliq_ipi",                      :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "ipi_base",                      :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "aliq_pis",                      :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "aliq_cofins",                   :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "desc_manaus",                   :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "pis_base",                      :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "cofins_base",                   :precision => 9,  :scale => 3, :default => 0.0, :null => false
    t.decimal  "net_weight",                    :precision => 10, :scale => 4
    t.decimal  "gross_weight",                  :precision => 10, :scale => 4
  end

  create_table "invoices", :force => true do |t|
    t.date     "operation"
    t.integer  "invoice_number"
    t.integer  "client_id"
    t.integer  "provider_id"
    t.integer  "seller_id"
    t.integer  "term_id"
    t.decimal  "ipi",                             :precision => 9, :scale => 3
    t.decimal  "icms_base",                       :precision => 9, :scale => 3
    t.decimal  "icms",                            :precision => 9, :scale => 3
    t.decimal  "pis",                             :precision => 9, :scale => 3
    t.decimal  "cofins",                          :precision => 9, :scale => 3
    t.decimal  "products_value",                  :precision => 9, :scale => 3
    t.decimal  "invoice_value",                   :precision => 9, :scale => 3
    t.decimal  "commission_rate",                 :precision => 9, :scale => 3
    t.integer  "activity_id"
    t.text     "observations"
    t.integer  "sell_id"
    t.integer  "parcels"
    t.integer  "natop_id"
    t.boolean  "delivery"
    t.decimal  "freight",                         :precision => 9, :scale => 3
    t.decimal  "insurance",                       :precision => 9, :scale => 3
    t.integer  "car_id"
    t.integer  "freight_type"
    t.boolean  "nfe"
    t.string   "nfe_received_key", :limit => 254
    t.string   "nfe_key",          :limit => 254
    t.string   "nfe_protocol",     :limit => 254
    t.integer  "nfe_env"
    t.decimal  "manaus_discount",                 :precision => 9, :scale => 3
    t.boolean  "canceled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
  end

  create_table "location_items", :force => true do |t|
    t.integer  "location_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "measure_unit_id"
    t.decimal  "unit_value",      :precision => 10, :scale => 2
    t.decimal  "total_value",     :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_receipt_items", :force => true do |t|
    t.integer  "location_receipt_id"
    t.string   "product"
    t.decimal  "quantity",            :precision => 10, :scale => 2
    t.decimal  "unit_value",          :precision => 10, :scale => 2
    t.decimal  "total_value",         :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_receipts", :force => true do |t|
    t.integer  "location_id"
    t.date     "start"
    t.date     "end"
    t.decimal  "discount",           :precision => 10, :scale => 2
    t.string   "discount_obs"
    t.decimal  "higher",             :precision => 10, :scale => 2
    t.string   "higher_obs"
    t.decimal  "month_value",        :precision => 10, :scale => 2
    t.decimal  "total_value",        :precision => 10, :scale => 2
    t.decimal  "liquid_value",       :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location_number"
    t.string   "enterp_name"
    t.string   "enterp_doc"
    t.string   "enterp_ie"
    t.string   "enterp_im"
    t.string   "enterp_address"
    t.string   "client_name"
    t.string   "client_doc"
    t.string   "client_ie"
    t.string   "client_im"
    t.string   "client_address"
    t.date     "location_starts_at"
    t.date     "location_ends_at"
    t.string   "period"
    t.text     "location_obs"
    t.string   "bank_name"
    t.string   "bank_ag"
    t.string   "bank_cc"
  end

  create_table "locations", :force => true do |t|
    t.string   "number"
    t.boolean  "quotation"
    t.string   "contact"
    t.integer  "client_id"
    t.integer  "seller_id"
    t.integer  "comission"
    t.integer  "payment_condition_id"
    t.date     "starts_at"
    t.date     "ends_at"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bank_account_id"
  end

  create_table "measure_units", :force => true do |t|
    t.integer "product_id"
    t.string  "measure_unit", :limit => 40
    t.boolean "main"
    t.decimal "ratio",                      :precision => 15, :scale => 5
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

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.decimal  "quantity",          :precision => 10, :scale => 4
    t.decimal  "total_value",       :precision => 10, :scale => 2
    t.date     "delivery"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "unit_value",        :precision => 10, :scale => 2
    t.integer  "measure_unit_id"
    t.decimal  "net_weight",        :precision => 10, :scale => 4
    t.decimal  "gross_weight",      :precision => 10, :scale => 4
    t.decimal  "quantity_produced", :precision => 10, :scale => 4
    t.boolean  "pend"
  end

  create_table "orders", :force => true do |t|
    t.string   "number",               :limit => 10
    t.integer  "order_type_id"
    t.integer  "sale_type_id"
    t.date     "date"
    t.date     "prevision"
    t.date     "billed"
    t.integer  "client_id"
    t.integer  "seller_id"
    t.decimal  "commission",                         :precision => 10, :scale => 4
    t.string   "contact",              :limit => 50
    t.integer  "payment_condition_id"
    t.decimal  "freight",                            :precision => 10, :scale => 4
    t.integer  "freight_type_id"
    t.integer  "attendant_id"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.boolean  "closed"
    t.integer  "car_id"
  end

  create_table "payable_billings", :force => true do |t|
    t.integer  "bank_account_id"
    t.integer  "provider_id"
    t.string   "history",         :limit => 150
    t.integer  "account_plan_id"
    t.integer  "cost_center_id"
    t.string   "document_number", :limit => 50
    t.string   "barcode",         :limit => 70
    t.text     "observations"
    t.datetime "expire_at"
    t.integer  "parcel"
    t.datetime "competency"
    t.datetime "received_at"
    t.string   "bill_number",     :limit => 50
    t.decimal  "value",                          :precision => 10, :scale => 2
    t.decimal  "fine",                           :precision => 10, :scale => 4
    t.decimal  "rate",                           :precision => 10, :scale => 4
    t.decimal  "discount",                       :precision => 10, :scale => 2
    t.decimal  "total",                          :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payable_id"
  end

  create_table "payable_cost_divisions", :force => true do |t|
    t.integer  "account_plan_id"
    t.integer  "cost_center_id"
    t.text     "observations"
    t.decimal  "value",           :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payable_id"
  end

  create_table "payables", :force => true do |t|
    t.integer  "invoice_number"
    t.integer  "parcel"
    t.date     "due_date"
    t.decimal  "value",                                   :precision => 9,  :scale => 3
    t.integer  "bank_id"
    t.string   "email"
    t.integer  "deposit_id"
    t.date     "payment_date"
    t.string   "collection_number"
    t.decimal  "daily_penalty",                           :precision => 9,  :scale => 3
    t.text     "observations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_id"
    t.text     "historic"
    t.datetime "issue_date"
    t.integer  "document_kind_id"
    t.integer  "account_id"
    t.integer  "payment_method_id"
    t.integer  "frequency_id"
    t.integer  "account_plan_id"
    t.date     "competence"
    t.string   "serie_number",             :limit => 50
    t.string   "carrier",                  :limit => 100
    t.string   "barcode",                  :limit => 40
    t.integer  "rate_type_id"
    t.decimal  "rate",                                    :precision => 10, :scale => 4
    t.decimal  "fine",                                    :precision => 10, :scale => 4
    t.integer  "rate_calculation_type_id"
    t.boolean  "settled"
  end

  create_table "payment_forms", :force => true do |t|
    t.string   "name",       :limit => 50
    t.integer  "parcels"
    t.integer  "p01"
    t.integer  "p02"
    t.integer  "p03"
    t.integer  "p04"
    t.integer  "p05"
    t.integer  "p06"
    t.integer  "p07"
    t.integer  "p08"
    t.integer  "p09"
    t.integer  "p10"
    t.integer  "p11"
    t.integer  "p12"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name",               :limit => 80
    t.integer  "external_id"
    t.string   "type"
    t.integer  "department_id"
    t.string   "email",              :limit => 70
    t.integer  "function_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_content_type"
    t.string   "photo_file_name"
    t.datetime "photo_updated_at"
    t.integer  "photo_file_size"
  end

  create_table "phones", :force => true do |t|
    t.integer  "person_id"
    t.string   "number",     :limit => 25
    t.boolean  "main"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_families", :force => true do |t|
    t.string   "name"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_kinds", :force => true do |t|
    t.string   "name"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "code",           :limit => 20
    t.string   "name",           :limit => 70
    t.string   "kind",           :limit => 50
    t.string   "unity"
    t.decimal  "ipi",                          :precision => 10, :scale => 4
    t.string   "fiscal_code",    :limit => 50
    t.integer  "tributary_code"
    t.string   "ncm",            :limit => 20
    t.decimal  "price",                        :precision => 10, :scale => 2
    t.decimal  "cost",                         :precision => 10, :scale => 2
    t.decimal  "liquid_price",                 :precision => 10, :scale => 2
    t.integer  "family_id"
    t.integer  "type_id"
    t.integer  "cst_icm_id"
    t.integer  "cst_ipi_id"
    t.integer  "cst_pis_id"
    t.integer  "cst_cofins_id"
    t.decimal  "pis",                          :precision => 10, :scale => 4
    t.decimal  "cofins",                       :precision => 10, :scale => 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "net_weight",                   :precision => 10, :scale => 4
    t.decimal  "gross_weight",                 :precision => 10, :scale => 4
    t.decimal  "width",                        :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "height",                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "depth",                        :precision => 10, :scale => 2, :default => 0.0
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
    t.string   "code",         :limit => 20
  end

  create_table "receivable_billings", :force => true do |t|
    t.integer  "bank_account_id"
    t.integer  "client_id"
    t.string   "history",         :limit => 150
    t.integer  "account_plan_id"
    t.integer  "cost_center_id"
    t.string   "document_number", :limit => 50
    t.string   "barcode",         :limit => 70
    t.text     "observations"
    t.datetime "expire_at"
    t.integer  "parcel"
    t.datetime "competency"
    t.datetime "received_at"
    t.string   "bill_number",     :limit => 50
    t.decimal  "value",                          :precision => 10, :scale => 2
    t.decimal  "fine",                           :precision => 10, :scale => 4
    t.decimal  "rate",                           :precision => 10, :scale => 4
    t.decimal  "discount",                       :precision => 10, :scale => 2
    t.decimal  "total",                          :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receivable_id"
  end

  create_table "receivable_cost_divisions", :force => true do |t|
    t.integer  "account_plan_id"
    t.integer  "cost_center_id"
    t.text     "observations"
    t.decimal  "value",           :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receivable_id"
  end

  create_table "receivables", :force => true do |t|
    t.integer  "invoice_number"
    t.integer  "parcel"
    t.date     "due_date"
    t.decimal  "value",                                   :precision => 9,  :scale => 3
    t.integer  "bank_id"
    t.string   "email"
    t.integer  "deposit_id"
    t.date     "payment_date"
    t.string   "collection_number"
    t.decimal  "daily_penalty",                           :precision => 9,  :scale => 3
    t.text     "observations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.text     "historic"
    t.datetime "issue_date"
    t.integer  "document_kind_id"
    t.integer  "account_id"
    t.integer  "payment_method_id"
    t.integer  "frequency_id"
    t.integer  "account_plan_id"
    t.date     "competence"
    t.string   "serie_number",             :limit => 50
    t.string   "carrier",                  :limit => 100
    t.string   "barcode",                  :limit => 40
    t.integer  "rate_type_id"
    t.decimal  "rate",                                    :precision => 10, :scale => 4
    t.decimal  "fine",                                    :precision => 10, :scale => 4
    t.integer  "rate_calculation_type_id"
    t.boolean  "settled"
    t.integer  "location_id"
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

  create_table "seller_credit_accounts", :force => true do |t|
    t.integer  "seller_id"
    t.string   "name"
    t.string   "historic"
    t.decimal  "credit",       :precision => 10, :scale => 2
    t.decimal  "debit",        :precision => 10, :scale => 2
    t.date     "date"
    t.text     "observations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sellers", :force => true do |t|
    t.string   "name"
    t.string   "contact"
    t.integer  "address_id"
    t.string   "core"
    t.string   "person"
    t.string   "cnpj"
    t.string   "document"
    t.boolean  "iss"
    t.string   "bank_name"
    t.string   "agency"
    t.string   "account"
    t.string   "inss_base"
    t.text     "observation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sells_types", :force => true do |t|
    t.string   "name",       :limit => 20
    t.text     "calc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "st_cofins", :force => true do |t|
    t.string   "name",              :limit => 100
    t.decimal  "aliquot",                          :precision => 10, :scale => 4
    t.boolean  "taxed"
    t.boolean  "differential_rate"
    t.boolean  "zero_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "st_icms", :force => true do |t|
    t.string   "name",            :limit => 80
    t.boolean  "taxed"
    t.boolean  "base_reduction"
    t.boolean  "tax_replacement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "st_ipis", :force => true do |t|
    t.string   "name",       :limit => 100
    t.string   "sai_ent",    :limit => 1
    t.boolean  "taxed"
    t.boolean  "zero_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "st_pis", :force => true do |t|
    t.string   "name",              :limit => 100
    t.decimal  "aliquot_pis",                      :precision => 10, :scale => 4
    t.boolean  "taxed"
    t.boolean  "differential_rate"
    t.boolean  "zero_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", :force => true do |t|
    t.integer  "product_id"
    t.string   "description"
    t.decimal  "quantity_out",                 :precision => 15, :scale => 6
    t.decimal  "quantity_in",                  :precision => 15, :scale => 6
    t.integer  "measure_unit_id"
    t.decimal  "total_before",                 :precision => 15, :scale => 6
    t.integer  "total_before_measure_unit_id"
    t.decimal  "total",                        :precision => 15, :scale => 6
    t.integer  "total_measure_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.string   "name",       :limit => 50
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
