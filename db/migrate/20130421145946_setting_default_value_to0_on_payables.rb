class SettingDefaultValueTo0OnPayables < ActiveRecord::Migration
  def self.up
    change_column_default :payables, :value, 0.00
  end

  def self.down
    execute "ALTER TABLE payables CHANGE value value decimal(9,3) DEFAULT NULL"
  end
end
