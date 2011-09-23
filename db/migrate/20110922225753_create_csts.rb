class CreateCsts < ActiveRecord::Migration
  def self.up
    create_table :csts do |t|
      t.string :code
      t.string :description
      t.string :type
    end
  end

  def self.down
    drop_table :csts
  end
end

