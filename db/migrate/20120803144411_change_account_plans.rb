class ChangeAccountPlans < ActiveRecord::Migration
  def self.up
    add_column :account_plans, :code      , :string , :null => false, :limit   => 11
    add_column :account_plans, :level     , :integer, :null => false, :default => 1
    add_column :account_plans, :analytical, :boolean, :null => false, :default => 1

    change_column :account_plans, :name, :string, :null => false, :limit => 50
  end

  def self.down
    remove_column :account_plans, :code
    remove_column :account_plans, :level
    remove_column :account_plans, :analytical

    change_column :account_plans, :name, :string, :null => true, :limit => 50
  end
end
