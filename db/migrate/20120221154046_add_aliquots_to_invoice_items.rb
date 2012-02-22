class AddAliquotsToInvoiceItems < ActiveRecord::Migration
  def self.up
    add_column :invoice_items, :aliq_icm   , :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
    add_column :invoice_items, :icm_base   , :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
    add_column :invoice_items, :aliq_ipi   , :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
    add_column :invoice_items, :ipi_base   , :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
    add_column :invoice_items, :aliq_pis   , :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
    add_column :invoice_items, :aliq_cofins, :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
  end

  def self.down
    remove_column :invoice_items, :aliq_icm   
    remove_column :invoice_items, :icm_base
    remove_column :invoice_items, :aliq_ipi   
    remove_column :invoice_items, :ipi_base
    remove_column :invoice_items, :aliq_pis   
    remove_column :invoice_items, :aliq_cofins
  end
end
