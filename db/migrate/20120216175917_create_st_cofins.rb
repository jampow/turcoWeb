class CreateStCofins < ActiveRecord::Migration
  def self.up
    create_table :st_cofins do |t|
      t.string :name    , :limit => 100
      t.decimal :aliquot, :precision => 10, :scale => 4
      t.boolean :taxed
      t.boolean :differential_rate
      t.boolean :zero_rate

      t.timestamps
    end
  end

  def self.down
    drop_table :st_cofins
  end
end
