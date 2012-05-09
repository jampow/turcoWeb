class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :number
      t.boolean :quotation
      t.string :contact
      t.integer :client_id
      t.integer :seller_id
      t.decimal :comission
      t.integer :payment_condition_id
      t.date :starts_at
      t.date :ends_at
      t.text :observation

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
