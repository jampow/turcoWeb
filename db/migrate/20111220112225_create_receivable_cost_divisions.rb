class CreateReceivableCostDivisions < ActiveRecord::Migration
  def self.up
    create_table :receivable_cost_divisions do |t|
      t.integer :account_plan_id
      t.integer :cost_center_id
      t.text :observations
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :receivable_cost_divisions
  end
end
