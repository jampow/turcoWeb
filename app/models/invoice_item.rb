class InvoiceItem < ActiveRecord::Base
  belongs_to :product
#Select ii.product_name,
#       ii.quantity,
#       mu.measure_unit,
#       ii.parts,
#       ii.unit_value,
#       ii.total_value,
#       ii.icm,
#       ii.ipi,
#       ii.pis,
#       ii.cofins
#From invoice_items ii Join
#     measure_units mu On mu.id = ii.measure_unit_id
 
  named_scope :grid_itens, lambda { |invoice_id|
   {:select     => 'ii.product_name, ii.quantity, mu.measure_unit, ii.parts, ii.unit_value, ii.total_value, ii.icm, ii.ipi, ii.pis, ii.cofins', 
    :joins      => 'ii Join measure_units mu On mu.id = ii.measure_unit_id',
    :conditions => ['ii.invoice_id = ?', invoice_id]}
  }

end
