class AddCpfToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :cpf, :string, :limit => 20
  end

  def self.down
    remove_column :clients, :cpf
  end
end
