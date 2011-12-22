class CreateSellers < ActiveRecord::Migration
  def self.up
    create_table :sellers do |t|
      t.string  :name
      t.string  :contact
      t.integer :address_id
      t.string  :core
      t.string  :person
      t.string  :cnpj
      t.string  :document
      t.boolean :iss
      t.integer :bank_id
      t.string  :agency
      t.string  :account
      t.string  :inss_base
      t.text    :observation

      t.timestamps
    end
  end

  def self.down
    drop_table :sellers
  end
end
