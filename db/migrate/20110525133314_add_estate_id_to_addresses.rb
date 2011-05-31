class AddEstateIdToAddresses < ActiveRecord::Migration
  def self.up
    add_column    :addresses, :estate_id, :integer
    remove_column :addresses, :estate_id
  end

  def self.down
    remove_column :addresses, :estate_id
    add_column    :addresses, :estate_id, :string
  end
end

