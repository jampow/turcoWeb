class CreateProductKinds < ActiveRecord::Migration
  def self.up
    create_table :product_kinds do |t|
      t.string :name
      t.text :observation

      t.timestamps
    end
  end

  def self.down
    drop_table :product_kinds
  end
end
