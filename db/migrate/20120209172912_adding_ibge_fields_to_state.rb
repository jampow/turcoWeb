class AddingIbgeFieldsToState < ActiveRecord::Migration
  def self.up
    add_column :estates, :ibge_cod, :integer
  end

  def self.down
    remove_column :estates, :ibge_cod
  end
end

