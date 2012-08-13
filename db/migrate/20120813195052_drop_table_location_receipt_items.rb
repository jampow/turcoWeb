class DropTableLocationReceiptItems < ActiveRecord::Migration
  def self.up
    drop_table :location_receipt_items
  end

  def self.down
    create_table :location_receipt_items do |t|
      t.integer :location_receipt_id
      t.string :product
      t.decimal :quantity   , :precision => 10, :scale => 2
      t.decimal :unit_value , :precision => 10, :scale => 2
      t.decimal :total_value, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
