class AlterBankColunOnSellers < ActiveRecord::Migration
  def self.up
    rename_column :sellers, :bank_id  , :bank_name
    change_column :sellers, :bank_name, :string
  end

  def self.down
    rename_column :sellers, :bank_name, :bank_id
    change_column :sellers, :bank_id  , :integer
  end
end
