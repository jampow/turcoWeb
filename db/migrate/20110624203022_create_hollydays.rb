class CreateHollydays < ActiveRecord::Migration
  def self.up
    create_table :hollydays do |t|
      t.date :date
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :hollydays
  end
end
