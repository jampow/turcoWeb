class AddValueToCsts < ActiveRecord::Migration
  def self.up
    add_column :csts, :value, :float
  end

  def self.down
    remove_column :csts, :value
  end
end
