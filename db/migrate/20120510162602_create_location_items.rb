class CreateLocationItems < ActiveRecord::Migration
  def self.up
    create_table :location_items do |t|
      t.integer :location_id
      t.integer :product_id
      t.integer :quantity
      t.integer :measure_unit_id
      t.decimal :unit_value , :precision => 10, :scale => 2
      t.decimal :total_value, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :location_items
  end
end
