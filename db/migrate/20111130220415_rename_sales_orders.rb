class RenameSalesOrders < ActiveRecord::Migration
  def self.up
    rename_table  'sales_orders'     , 'orders'
    rename_table  'sales_order_items', 'order_items'
    add_column    'orders', 'type', :string
    rename_column 'order_items', 'sales_order_id', 'order_id'
  end

  def self.down
    rename_column 'order_items', 'order_id', 'sales_order_id'
    remove_column 'orders', 'type'
    rename_table  'order_items', 'sales_order_items'
    rename_table  'orders'     , 'sales_orders'
  end
end

