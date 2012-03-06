class CreateCarriers < ActiveRecord::Migration
  def self.up
    create_table :carriers do |t|
      t.string :name    , :limit => 70
      t.string :nickname, :limit => 50
      t.string :cnpj    , :limit => 18
      t.string :ie      , :limit => 15
      t.integer :address_id

      t.timestamps
    end
  end

  def self.down
    drop_table :carriers
  end
end
