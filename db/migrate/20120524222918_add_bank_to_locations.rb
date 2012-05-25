class AddBankToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :bank_account_id, :integer
  end

  def self.down
    remove_column :locations, :bank_account_id
  end
end
