class AddProviderIdToInvoices < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      Alter Table invoices
        Add Column provider_id int(11) After client_id
    SQL
  end

  def self.down
    remove_column :invoices, :provider_id
  end
end

