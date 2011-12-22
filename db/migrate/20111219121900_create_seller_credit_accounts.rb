class CreateSellerCreditAccounts < ActiveRecord::Migration
  def self.up
    create_table :seller_credit_accounts do |t|
      t.integer :seller_id
      t.string :name
      t.string :historic
      t.float :credit
      t.float :debit
      t.date :date
      t.text :observations

      t.timestamps
    end
  end

  def self.down
    drop_table :seller_credit_accounts
  end
end
