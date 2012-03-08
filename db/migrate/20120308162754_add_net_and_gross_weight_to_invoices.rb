class AddNetAndGrossWeightToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoice_items, :net_weight  , :decimal, :precision => 10, :scale => 4
    add_column :invoice_items, :gross_weight, :decimal, :precision => 10, :scale => 4

    add_column :order_items, :net_weight  , :decimal, :precision => 10, :scale => 4
    add_column :order_items, :gross_weight, :decimal, :precision => 10, :scale => 4

    remove_column :products, :weight
    add_column    :products, :net_weight  , :decimal, :precision => 10, :scale => 4
    add_column    :products, :gross_weight, :decimal, :precision => 10, :scale => 4
  end

  def self.down
    remove_column :invoice_items, :net_weight
    remove_column :invoice_items, :gross_weight

    remove_column :order_items, :net_weight
    remove_column :order_items, :gross_weight

    add_column    :products, :weight, :decimal, :precision => 10, :scale => 3
    remove_column :products, :net_weight
    remove_column :products, :gross_weight
  end
end
