class CreateSalesOrders < ActiveRecord::Migration
  def self.up
    create_table :sales_orders do |t|
      t.string :number
      t.integer :order_type_id
      t.integer :sale_type_id
      t.date :date
      t.date :prevision
      t.date :billed
      t.integer :client_id
      t.integer :seller_id
      t.float :commission
      t.integer :contact_id
      t.integer :payment_condition_id
      t.integer :carrier_id
      t.float :freight
      t.integer :freight_type_id
      t.integer :attendant_id
      t.text :observation

      t.timestamps
    end
  end

  def self.down
    drop_table :sales_orders
  end
end
