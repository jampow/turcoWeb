class AddEstateIdToAddresses < ActiveRecord::Migration
  def self.up
    rename_column :addresses, :estate,    :estate_id
    change_column :addresses, :estate_id, :integer
  end

  def self.down
    rename_column :addresses, :estate_id, :estate
    change_column :addresses, :estate,    :string
  end
end

