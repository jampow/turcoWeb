class CreateInvoiceItems < ActiveRecord::Migration
  def self.up
    create_table :invoice_items do |t|
      t.integer :invoice_id
      t.integer :product_id
      t.string  :product_cod    , :limit => 20
      t.string  :product_name   , :limit => 60
      t.decimal :quantity       , :precision => 9, :scale => 3
      t.integer :measure_unit_id
      t.integer :parts
      t.decimal :unit_value     , :precision => 9, :scale => 3
      t.decimal :total_value    , :precision => 9, :scale => 3
      t.decimal :icm            , :precision => 9, :scale => 3
      t.decimal :ipi            , :precision => 9, :scale => 3
      t.decimal :pis            , :precision => 9, :scale => 3
      t.decimal :cofins         , :precision => 9, :scale => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :invoice_items
  end
end
