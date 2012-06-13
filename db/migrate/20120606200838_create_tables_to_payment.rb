class CreateTablesToPayment < ActiveRecord::Migration
  def self.up
    create_table "payable_billings" do |t|
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
      t.integer  "payable_id"
    end

    create_table "payable_cost_divisions" do |t|
      t.integer  "account_plan_id"
      t.integer  "cost_center_id"
      t.text     "observations"
      t.decimal  "value",           :precision => 10, :scale => 2
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "payable_id"
    end

    create_table "payables" do |t|
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
    end
  end

  def self.down
    drop_table "payable_billings"
    drop_table "payable_cost_divisions"
    drop_table "payables"
  end
end
