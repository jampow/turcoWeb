class AddReceivableIdToReceivableBillings < ActiveRecord::Migration
  def self.up
    add_column :receivable_billings, :receivable_id, :integer
  end

  def self.down
    remove_column :receivable_billings, :receivable_id
  end
end
