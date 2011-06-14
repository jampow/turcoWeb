class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many   :receivables, :primary_key => "invoice_number", :foreign_key => "invoice_number"
end

