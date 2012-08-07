class AddOrientationIdToAccountPlans < ActiveRecord::Migration
  def self.up
    add_column :account_plans, :orientation_id, :integer, :default => 1
  end

  def self.down
    remove_column :account_plans, :orientation_id
  end
end
