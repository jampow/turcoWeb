class CreateStIcms < ActiveRecord::Migration
  def self.up
    create_table :st_icms do |t|
      t.string  :name           , :limit => 80
      t.boolean :taxed
      t.boolean :base_reduction
      t.boolean :tax_replacement

      t.timestamps
    end
  end

  def self.down
    drop_table :st_icms
  end
end
