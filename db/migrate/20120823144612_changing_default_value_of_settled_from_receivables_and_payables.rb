class ChangingDefaultValueOfSettledFromReceivablesAndPayables < ActiveRecord::Migration
  def self.up
    change_column :receivables, :settled, :boolean, :default => false
    change_column :payables   , :settled, :boolean, :default => false
  end

  def self.down
    change_column :receivables, :settled, :boolean
    change_column :payables   , :settled, :boolean
  end
end
