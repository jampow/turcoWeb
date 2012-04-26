class ChangeOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.rename :contact_id, :contact
      t.change :contact, :string, :limit => 50
    end
  end

  def self.down
    change_table :orders do |t|
      t.change :contact, :integer
      t.rename :contact, :contact_id
    end
  end
end
