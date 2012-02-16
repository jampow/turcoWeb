class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :provider
  belongs_to :seller
  belongs_to :sell_type, :foreign_key => "sell_id"
  belongs_to :term
  belongs_to :receivables, :foreign_key => "invoice_number"
  has_many   :receivables, :primary_key => "invoice_number", :foreign_key => "invoice_number"
  has_many   :itens, :class_name => "InvoiceItem"
  
  accepts_nested_attributes_for :itens, :reject_if => proc { |a| a[:product_name].blank? || a[:product_id].blank? }
  
  attr_accessor :client_name
  
  named_scope :grid, 
    :select => 'inv.id, cli.name, inv.operation',
    :joins  => 'inv Join clients cli On cli.id = inv.client_id', 
    :order  => "name"
end

