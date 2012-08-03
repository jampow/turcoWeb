class DropTableLocationReceipts < ActiveRecord::Migration
  def self.up
    drop_table :location_receipts
  end

  def self.down
    create_table :location_receipts do |t|
      t.integer :location_id
      t.date :start
      t.date :end
      t.decimal :discount
      t.string :discount_obs
      t.decimal :higher
      t.string :higher_obs
      t.decimal :month_value , :precision => 10, :scale => 2
      t.decimal :total_value , :precision => 10, :scale => 2
      t.decimal :liquid_value, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end