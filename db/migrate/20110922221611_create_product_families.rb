class CreateProductFamilies < ActiveRecord::Migration
  def self.up
    create_table :product_families do |t|
      t.string :name
      t.text :observation

      t.timestamps
    end
  end

  def self.down
    drop_table :product_families
  end
end
