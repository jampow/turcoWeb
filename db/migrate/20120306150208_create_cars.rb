class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars do |t|
      t.integer :carrier_id
      t.string  :license_plate, :limit => 8
      t.integer :estate_id
      t.string  :brand        , :limit => 30

      t.timestamps
    end
  end

  def self.down
    drop_table :cars
  end
end
