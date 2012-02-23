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

  # ICMS =======================================================================
  def calc_icms(sell, activity, aliq)
    self.icm_base = self.total_value
    self.icm_base = self.ipi if sell && activity.downcase != "indústria"
    self.aliq_icm = aliq
    self.icm      = self.icm_base * (self.aliq_icm / 100)
  end
  
  def zero_icms
    self.icm_base, self.aliq_icm, self.icm = 0, 0, 0
  end

  # IPI ========================================================================
  def calc_ipi
    if self.aliq_ipi > 0
      self.ipi = self.total_value * (self.aliq_ipi / 100)
    end
  end
  
  def zero_ipi
    self.ipi_base, self.aliq_ipi, self.ipi = 0, 0, 0
  end

  # PIS ========================================================================
  def calc_pis
    self.pis_base = self.total_value
    self.aliq_pis = self.product.pis
    self.pis      = self.total_value * (self.aliq_pis / 100)
  end
  
  # COFINS =====================================================================
  def calc_cofins
    self.cofins_base = self.total_value
    self.aliq_cofins = self.product.cofins
    self.cofins      = self.cofins_base * (self.aliq_cofins / 100)
  end
end
