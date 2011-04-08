class CreateNcms < ActiveRecord::Migration
  def self.up
    create_table :ncms do |t|
      t.string :code
      t.string :description
      t.string :unit
      t.integer :ipi

      t.timestamps
    end
  end

  def self.down
    drop_table :ncms
  end
end
