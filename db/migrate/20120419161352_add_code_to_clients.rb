class AddCodeToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :code, :string, :limit => 20
  end

  def self.down
    remove_column :clients, :code
  end
end
