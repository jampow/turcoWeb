class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer :father_id
      t.boolean :rubric
      t.integer :order
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
