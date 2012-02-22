class AddIcmsToEstates < ActiveRecord::Migration
  def self.up
    add_column :estates, :aliq_icms, :decimal, :precision => 9, :scale => 3, :null => false, :default => 0
  end

  def self.down
    remove_column :estates, :aliq_icms
  end
end
