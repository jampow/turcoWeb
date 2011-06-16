class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.date :operation
      t.integer :invoice_number
      t.integer :client_id
      t.integer :seller_id
      t.integer :term_id
      t.decimal :ipi            , :precision => 9, :scale => 3
      t.decimal :icms_base      , :precision => 9, :scale => 3
      t.decimal :icms           , :precision => 9, :scale => 3
      t.decimal :pis            , :precision => 9, :scale => 3
      t.decimal :cofins         , :precision => 9, :scale => 3
      t.decimal :products_value , :precision => 9, :scale => 3
      t.decimal :invoice_value  , :precision => 9, :scale => 3
      t.decimal :commission_rate, :precision => 9, :scale => 3
      t.integer :activity_id
      t.text :observations
      t.integer :sell_id
      t.integer :parcels
      t.integer :natop_id
      t.boolean :delivery
      t.decimal :freight        , :precision => 9, :scale => 3
      t.decimal :insurance      , :precision => 9, :scale => 3
      t.integer :carrier_id
      t.integer :freight_type
      t.boolean :nfe
      t.string :nfe_received_key
      t.string :nfe_key
      t.string :nfe_protocol
      t.integer :nfe_env
      t.decimal :manaus_discount, :precision => 9, :scale => 3
      t.boolean :canceled

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end

