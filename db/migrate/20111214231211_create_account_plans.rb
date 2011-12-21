class CreateAccountPlans < ActiveRecord::Migration
  def self.up
    create_table :account_plans do |t|
      t.string :name, :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :account_plans
  end
end
