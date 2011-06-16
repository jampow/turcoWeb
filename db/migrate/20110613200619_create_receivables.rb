class CreateReceivables < ActiveRecord::Migration
  def self.up
    create_table :receivables do |t|
      t.integer :invoice_number
      t.integer :parcel
      t.date :due_date
      t.decimal :value, :precision => 9, :scale => 3
      t.integer :bank_id
      t.string :email
      t.integer :deposit_id
      t.date :payment_date
      t.string :collection_number
      t.decimal :daily_penalty, :precision => 9, :scale => 3
      t.text :observations

      t.timestamps
    end
  end

  def self.down
    drop_table :receivables
  end
end

