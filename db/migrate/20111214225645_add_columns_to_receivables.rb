class AddColumnsToReceivables < ActiveRecord::Migration
  def self.up
    add_column :receivables, :client_id, :integer
    add_column :receivables, :historic, :text
    add_column :receivables, :issue_date, :datetime
    add_column :receivables, :document_kind_id, :integer
    add_column :receivables, :account_id, :integer
    add_column :receivables, :payment_method_id, :integer
    add_column :receivables, :frequency_id, :integer
    add_column :receivables, :account_plan_id, :integer
  end

  def self.down
    remove_column :receivables, :account_plan_id
    remove_column :receivables, :frequency_id
    remove_column :receivables, :payment_method_id
    remove_column :receivables, :account_id
    remove_column :receivables, :document_kind_id
    remove_column :receivables, :issue_date
    remove_column :receivables, :historic
    remove_column :receivables, :client_id
  end
end
