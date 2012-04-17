class AddPendToOrderItem < ActiveRecord::Migration
  def self.up
    add_column :order_items, :pend, :boolean
  end

  def self.down
    remove_column :order_items, :pend
  end
end
