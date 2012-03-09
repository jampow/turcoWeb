class RenameCarrierIdToCarIdIntoInvoices < ActiveRecord::Migration
  def self.up
    rename_column :invoices, :carrier_id, :car_id
  end

  def self.down
    rename_column :invoices, :car_id, :carrier_id
  end
end
