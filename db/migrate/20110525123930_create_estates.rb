class CreateEstates < ActiveRecord::Migration
  def self.up
    create_table :estates do |t|
      t.string :acronym
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :estates
  end
end
