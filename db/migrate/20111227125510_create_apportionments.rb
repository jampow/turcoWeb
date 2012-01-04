class CreateApportionments < ActiveRecord::Migration
  def self.up
    create_table :apportionments do |t|
      t.integer :account_plan_id
      t.integer :cost_center_id
      t.string  :cost_center_name
      t.float   :rate
      t.timestamps
    end
  end

  def self.down
    drop_table :apportionments
  end
end
