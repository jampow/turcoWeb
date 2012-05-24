class AjustDecimalsInLocationReceipt < ActiveRecord::Migration
  def self.up
    change_table :location_receipts do |t|
      t.change :discount, :decimal, :precision => 10, :scale => 2
      t.change :higher  , :decimal, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :location_receipts do |t|
      t.change :discount, :decimal, :precision => 10, :scale => 0
      t.change :higher  , :decimal, :precision => 10, :scale => 0
    end
  end
end
