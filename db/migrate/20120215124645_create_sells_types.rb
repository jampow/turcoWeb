class CreateSellsTypes < ActiveRecord::Migration
  def self.up
    create_table :sells_types do |t|
      t.string :name, :limit => 20
      t.text :calc

      t.timestamps
    end
  end

  def self.down
    drop_table :sells_types
  end
end
