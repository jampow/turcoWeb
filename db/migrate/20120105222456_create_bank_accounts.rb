class CreateBankAccounts < ActiveRecord::Migration
  def self.up
    create_table :bank_accounts do |t|
      t.string  :contact
      t.string  :bank_name
      t.string  :phone
      t.string  :fax
      t.string  :email_cob
      t.string  :email_ger
      t.integer :address_id
      t.string  :manager
      t.string  :manager_cel
      t.string  :agency_number
      t.string  :account_number
      t.text    :observations

      t.timestamps
    end
    
    drop_table :accounts
    
  end

  def self.down
    drop_table :bank_accounts
    
    create_table :accounts do |t|
      t.string :name, :limit => 50

      t.timestamps
    end
    
  end
end
