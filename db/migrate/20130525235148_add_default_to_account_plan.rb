class AddDefaultToAccountPlan < ActiveRecord::Migration
  def self.up
    add_column :account_plans, :default, :boolean, :default => false
  end

  def self.down
    remove_column :account_plans, :default
  end
end
