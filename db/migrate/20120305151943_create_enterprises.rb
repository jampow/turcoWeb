class CreateEnterprises < ActiveRecord::Migration
  def self.up
    create_table :enterprises do |t|
      t.string  :name      , :limit => 70
      t.string  :cnpj      , :limit => 18
      t.string  :ie        , :limit => 15
      t.string  :nickname  , :limit => 50
      t.integer :address_id
      t.string  :phone     , :limit => 30

      t.integer  :danfe_orientation
      t.integer  :nfe_ambient

      t.timestamps
    end
  end

  def self.down
    drop_table :enterprises
  end
end
