class ChangeClientIdToProviderIdOnPayablesAndPayableBillings < ActiveRecord::Migration
  def self.up
    rename_column :payable_billings, :client_id, :provider_id
    rename_column :payables        , :client_id, :provider_id
  end

  def self.down
    rename_column :payable_billings, :provider_id, :client_id
    rename_column :payables        , :provider_id, :client_id
  end
end
