class CreateStIpis < ActiveRecord::Migration
  def self.up
    create_table :st_ipis do |t|
      t.string :name      , :limit => 100
      t.string :sai_ent   , :limit => 1
      t.boolean :taxed
      t.boolean :zero_rate

      t.timestamps
    end
  end

  def self.down
    drop_table :st_ipis
  end
end
