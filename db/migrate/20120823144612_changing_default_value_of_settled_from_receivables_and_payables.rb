class ChangingDefaultValueOfSettledFromReceivablesAndPayables < ActiveRecord::Migration
  def self.up
    change_column_default :receivables, :settled, :boolean, false
    change_column_default :payables   , :settled, :boolean, false
  end

  def self.down
    change_column :receivables, :settled, :boolean
    change_column :payables   , :settled, :boolean
  end
end
