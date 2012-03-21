class LimitCstsCode < ActiveRecord::Migration
  def self.up
    change_column :csts, :code, :string, :limit => 2
  end

  def self.down
    change_column :csts, :code, :string, :limit => 20
  end
end
