class CreateMeasureUnits < ActiveRecord::Migration
  def self.up
    create_table :measure_units do |t|
      t.integer :product_id
      t.string :measure_unit
      t.boolean :main
      t.decimal :ratio, :precision => 15, :scale => 5
    end
  end

  def self.down
    drop_table :measure_units
  end
end
