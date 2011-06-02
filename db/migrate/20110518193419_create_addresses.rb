class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string  :street
      t.string  :number
      t.string  :complement
      t.string  :neighborhood
      t.string  :city
      t.string  :estate
      t.string  :country
      t.integer :cep
      t.string  :addressable_type
      t.integer :addressable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end

