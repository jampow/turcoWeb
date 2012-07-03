class AddDimentionsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :width , :decimal, :precision => 10, :scale => 2, :default => 0
    add_column :products, :height, :decimal, :precision => 10, :scale => 2, :default => 0
    add_column :products, :depth , :decimal, :precision => 10, :scale => 2, :default => 0
  end

  def self.down
    remove_column :products, :depth
    remove_column :products, :height
    remove_column :products, :width
  end
end
