class AddLocationIdToReceivables < ActiveRecord::Migration
  def self.up
    add_column :receivables, :location_id, :integer
  end

  def self.down
    remove_column :receivables, :location_id
  end
end
