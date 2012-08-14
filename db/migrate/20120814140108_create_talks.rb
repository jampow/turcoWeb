class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.integer :from_id
      t.integer :to_id
      t.text :text
      t.boolean :read

      t.timestamps
    end
  end

  def self.down
    drop_table :talks
  end
end
