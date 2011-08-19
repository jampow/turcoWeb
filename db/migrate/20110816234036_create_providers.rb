class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string   :name
      t.string   :prod_cost   , :limit => 1
      t.integer  :address_id
      t.string   :phone
      t.string   :fax
      t.string   :email
      t.boolean  :carrier
      t.string   :ie
      t.string   :cnpj
      t.string   :bank
      t.text     :observations
      t.integer  :seller_id
      t.integer  :invoicer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end

