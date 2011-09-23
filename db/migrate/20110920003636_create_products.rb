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
      t.integer  :cst_icm_id
      t.integer  :cst_ipi_id
      t.integer  :cst_pis_id
      t.integer  :cst_cofins_id
      t.float    :pis
      t.float    :cofins

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end

