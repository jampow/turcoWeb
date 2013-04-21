class SettingDefaultValueTo0OnReceivables < ActiveRecord::Migration
  def self.up
    change_column_default :receivables, :value, 0.00
  end

  def self.down
    execute "ALTER TABLE receivables CHANGE value value decimal(9,3) DEFAULT NULL"
  end
end
