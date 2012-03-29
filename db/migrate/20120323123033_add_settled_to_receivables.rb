class AddSettledToReceivables < ActiveRecord::Migration
  def self.up
    add_column :receivables, :settled, :boolean
  end

  def self.down
    remove_column :receivables, :settled
  end
end
