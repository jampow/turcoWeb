class CreateSalesOrderItems < ActiveRecord::Migration
  def self.up
    create_table :sales_order_items do |t|
      t.integer :sales_order_id
      t.integer :product_id
      t.string :product_name
      t.float :quantity
      t.float :unit_value
      t.float :total_value
      t.date :delivery

      t.timestamps
    end
  end

  def self.down
    drop_table :sales_order_items
  end
end
