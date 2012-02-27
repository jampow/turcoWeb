class AddPisBaseAndCofinsBaseToInvoiceItems < ActiveRecord::Migration
  def self.up
    add_column :invoice_items, :pis_base   , :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
    add_column :invoice_items, :cofins_base, :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
  end

  def self.down
    remove_column :invoice_items, :pis_base
    remove_column :invoice_items, :cofins_base
  end
end
