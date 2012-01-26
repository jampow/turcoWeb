class CreateReceivableBillings < ActiveRecord::Migration
  def self.up
    create_table :receivable_billings do |t|
      t.integer :bank_account_id
      t.integer :client_id
      t.string :history, :limit => 150
      t.integer :account_plan_id
      t.integer :cost_center_id
      t.string :document_number, :limit => 50
      t.string :barcode, :limit => 70
      t.text :observations
      t.datetime :expire_at
      t.integer :parcel
      t.datetime :competency
      t.datetime :received_at
      t.string :bill_number, :limit => 50
      t.float :value
      t.float :fine
      t.float :rate
      t.float :discount
      t.float :total

      t.timestamps
    end
  end

  def self.down
    drop_table :receivable_billings
  end
end
