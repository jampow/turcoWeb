class AddMeasureUnitsToOrderItems < ActiveRecord::Migration
  def self.up
    add_column    :order_items, :measure_unit_id, :integer
    remove_column :order_items, :product_name
  end

  def self.down
    remove_column :order_items, :measure_unit_id
    add_column    :order_items, :unit_value     , :float
  end
end
