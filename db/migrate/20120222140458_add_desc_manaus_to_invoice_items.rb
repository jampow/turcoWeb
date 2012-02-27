class AddDescManausToInvoiceItems < ActiveRecord::Migration
  def self.up
    add_column :invoice_items, :desc_manaus, :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
  end

  def self.down
    remove_column :invoice_items, :desc_manaus
  end
end
