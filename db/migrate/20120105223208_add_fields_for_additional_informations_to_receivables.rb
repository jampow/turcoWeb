class AddFieldsForAdditionalInformationsToReceivables < ActiveRecord::Migration
  def self.up
    add_column :receivables, :competence, :date
    add_column :receivables, :serie_number, :string, :limit => 50
    add_column :receivables, :carrier, :string, :limit => 100
    add_column :receivables, :barcode, :string, :limit => 40
    add_column :receivables, :rate_type_id, :integer
    add_column :receivables, :rate, :float
    add_column :receivables, :fine, :float
    add_column :receivables, :rate_calculation_type_id, :integer
  end

  def self.down
    remove_column :receivables, :competence
    remove_column :receivables, :serie_number
    remove_column :receivables, :carrier
    remove_column :receivables, :barcode
    remove_column :receivables, :rate_type_id
    remove_column :receivables, :rate
    remove_column :receivables, :fine
    remove_column :receivables, :rate_calculation_type_id
  end
end
