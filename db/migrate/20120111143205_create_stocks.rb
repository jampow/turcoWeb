class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      t.integer :product_id
      t.string  :description
      t.decimal :quantity_out                , :precision => 15, :scale => 6         
      t.decimal :quantity_in                 , :precision => 15, :scale => 6        
      t.integer :measure_unit_id
      t.decimal :total_before                , :precision => 15, :scale => 6         
      t.integer :total_before_measure_unit_id
      t.decimal :total                       , :precision => 15, :scale => 6  
      t.integer :total_measure_unit_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :stocks
  end
end
