class CreatePaymentForms < ActiveRecord::Migration
  def self.up
    create_table :payment_forms do |t|
      t.string :name
      t.integer :parcels
      t.integer :p01
      t.integer :p02
      t.integer :p03
      t.integer :p04
      t.integer :p05
      t.integer :p06
      t.integer :p07
      t.integer :p08
      t.integer :p09
      t.integer :p10
      t.integer :p11
      t.integer :p12

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_forms
  end
end
