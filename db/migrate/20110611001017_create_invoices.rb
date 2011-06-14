class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.date :operation
      t.integer :invoice_number
      t.integer :client_id
      t.integer :seller_id
      t.integer :term_id
      t.decimal :ipi
      t.decimal :icms_base
      t.decimal :icms
      t.decimal :pis
      t.decimal :cofins
      t.decimal :products_value
      t.decimal :invoice_value
      t.decimal :commission_rate
      t.integer :activity_id
      t.text :observations
      t.integer :sell_id
      t.integer :parcels
      t.integer :natop_id
      t.boolean :delivery
      t.decimal :freight
      t.decimal :insurance
      t.integer :carrier_id
      t.integer :freight_type
      t.boolean :nfe
      t.string :nfe_received_key
      t.string :nfe_key
      t.string :nfe_protocol
      t.integer :nfe_env
      t.decimal :manaus_discount
      t.boolean :canceled

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
