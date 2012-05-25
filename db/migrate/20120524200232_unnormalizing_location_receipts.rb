class UnnormalizingLocationReceipts < ActiveRecord::Migration
  def self.up
    change_table :location_receipts do |t|
      t.string :location_number

      t.string :enterp_name
      t.string :enterp_doc
      t.string :enterp_ie
      t.string :enterp_im
      t.string :enterp_address

      t.string :client_name
      t.string :client_doc
      t.string :client_ie
      t.string :client_im
      t.string :client_address

      t.date   :location_starts_at
      t.date   :location_ends_at
      t.string :period
      t.text   :location_obs

      t.string :bank_name
      t.string :bank_ag
      t.string :bank_cc
    end
  end

  def self.down
    change_table :location_receipts do |t|
      t.remove :location_number

      t.remove :enterp_name
      t.remove :enterp_doc
      t.remove :enterp_ie
      t.remove :enterp_im
      t.remove :enterp_address

      t.remove :client_name
      t.remove :client_doc
      t.remove :client_ie
      t.remove :client_im
      t.remove :client_address

      t.remove :location_starts_at
      t.remove :location_ends_at
      t.remove :period
      t.remove :location_obs

      t.remove :bank_name
      t.remove :bank_ag
      t.remove :bank_cc
    end
  end
end
