class AddQuantityProducedToOrderItems < ActiveRecord::Migration
  def self.up
    add_column :order_items, :quantity_produced, :decimal, :precision => 10, :scale => 4
  end

  def self.down
    remove_column :order_items, :quantity_produced
  end
end
