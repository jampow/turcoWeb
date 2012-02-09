class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string  :estate_acronym, :limit => 2
      t.integer :ibge_cod 
      t.string  :name          , :limit => 40
    end
  end

  def self.down
    drop_table :cities
  end
end
