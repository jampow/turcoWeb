class CreateCfops < ActiveRecord::Migration
  def self.up
    create_table :cfops do |t|
      t.integer :number, :null => false
      t.string  :name  , :null => false, :limit => 40

      t.timestamps
    end
  end

  def self.down
    drop_table :cfops
  end
end
