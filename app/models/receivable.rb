class Receivable < ActiveRecord::Base
  belongs_to :invoice, :primary_key => "invoice_number", :foreign_key => "invoice_number"
end

