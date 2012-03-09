class AddCarIdToOrders < ActiveRecord::Migration
  def self.up
  	add_column :orders, :car_id, :integer
  	remove_column :orders, :carrier_id
  end

  def self.down
  	remove_column :orders, :car_id
  	add_column :orders, :carrier_id, :integer
  end
end
