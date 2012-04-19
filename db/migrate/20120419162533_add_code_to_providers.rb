class AddCodeToProviders < ActiveRecord::Migration
  def self.up
    add_column :providers, :code, :string, :limit => 20
  end

  def self.down
    remove_column :providers, :code
  end
end
