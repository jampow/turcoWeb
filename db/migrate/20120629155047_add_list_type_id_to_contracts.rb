class AddListTypeIdToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :list_type_id, :integer
  end

  def self.down
    remove_column :contracts, :list_type_id
  end
end
