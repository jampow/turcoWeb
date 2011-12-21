class AddReceivableIdToReceivableCostDivisions < ActiveRecord::Migration
  def self.up
    add_column :receivable_cost_divisions, :receivable_id, :integer
  end

  def self.down
    remove_column :receivable_cost_divisions, :receivable_id
  end
end
