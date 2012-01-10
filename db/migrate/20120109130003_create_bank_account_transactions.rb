class CreateBankAccountTransactions < ActiveRecord::Migration
  def self.up
    create_table :bank_account_transactions do |t|
      t.integer :bank_account_id
      t.string  :name
      t.string  :historic
      t.decimal :debit , :precision => 9, :scale => 3
      t.decimal :credit, :precision => 9, :scale => 3
      t.date    :date

      t.timestamps
    end
  end

  def self.down
    drop_table :bank_account_transactions
  end
end
