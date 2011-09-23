class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string   :code
      t.string   :name
      t.string   :kind
      t.string   :unity
      t.float    :weight
      t.float    :ipi
      t.string   :fiscal_code
      t.integer  :tributary_code
      t.string   :ncm
      t.float    :price
      t.float    :cost
      t.float    :liquid_price
      t.integer  :family_id
      t.integer  :type_id
      t.integer  :csticm_id
      t.integer  :cstipi_id
      t.integer  :cstpis_id
      t.float    :pis
      t.integer  :cstcofins_id
      t.float    :cofins

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end

