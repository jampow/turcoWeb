class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.string :nickname
      t.string :cnpj
      t.string :ie
      t.boolean :active
      t.string :sci
      t.string :activity
      t.integer :main_address_id
      t.integer :billing_address_id
      t.integer :delivery_address_id

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
