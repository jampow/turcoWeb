class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :receivables, :foreign_key => "invoice_number"
  has_many   :receivables, :primary_key => "invoice_number", :foreign_key => "invoice_number"
end

