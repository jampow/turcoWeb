class SettingDefaultValueTo0OnPayableAndReceivableCostDivisions < ActiveRecord::Migration
  def self.up
    change_column_default :payable_cost_divisions, :value, 0.00
    change_column_default :receivable_cost_divisions, :value, 0.00
  end

  def self.down
    execute "ALTER TABLE payable_cost_divisions CHANGE value value decimal(9,3) DEFAULT NULL"
    execute "ALTER TABLE receivable_cost_divisions CHANGE value value decimal(9,3) DEFAULT NULL"
  end
end
