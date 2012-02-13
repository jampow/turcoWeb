class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :provider
  belongs_to :seller
  belongs_to :term
  belongs_to :receivables, :foreign_key => "invoice_number"
  has_many   :receivables, :primary_key => "invoice_number", :foreign_key => "invoice_number"
  
  attr_accessor :client_name
end

