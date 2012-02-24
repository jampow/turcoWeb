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
   {:select     => 'ii.product_name, ii.quantity, mu.measure_unit, ii.parts, ii.unit_value, ii.total_value, ii.icm, ii.ipi, ii.pis, ii.cofins, ii.aliq_ipi', 
    :joins      => 'ii Left Join measure_units mu On mu.id = ii.measure_unit_id',
    :conditions => ['ii.invoice_id = ?', invoice_id]}
  }

  # ICMS =======================================================================
  def calc_icms(sell, activity, aliq)
    self.icm_base =  self.total_value
    self.icm_base += self.ipi if sell && activity.downcase != "indústria"
    self.aliq_icm =  aliq
    self.icm      =  self.icm_base * (self.aliq_icm / 100)
    #logger.info "IPI Somado: "+self.ipi.to_s if sell && activity.downcase != "indústria"
    #logger.info "ICMS Base: "+self.icm_base.to_s
    #logger.info "ICMS Aliq: "+self.aliq_icm.to_s
    #logger.info "ICMS Total: "+self.icm.to_s
  end
  
  def zero_icms
    self.icm_base, self.aliq_icm, self.icm = 0, 0, 0
    #logger.info "ICMS Base: "+self.icm_base.to_s
    #logger.info "ICMS Aliq: "+self.aliq_icm.to_s
    #logger.info "ICMS Total: "+self.icm.to_s
  end

  # IPI ========================================================================
  def calc_ipi
    if self.aliq_ipi > 0
      self.ipi = self.total_value * (self.aliq_ipi / 100)
      #logger.info "Calculando IPI"
      #logger.info "#{self.total_value} * (#{self.aliq_ipi} / 100)"
    end
    #logger.info "IPI Aliq: "+self.aliq_ipi.to_s
    #logger.info "IPI Total: "+self.ipi.to_s
  end
  
  def zero_ipi
    self.ipi_base, self.aliq_ipi, self.ipi = 0, 0, 0
    #logger.info "IPI Base: "+self.ipi_base.to_s
    #logger.info "IPI Aliq: "+self.aliq_ipi.to_s
    #logger.info "IPI Total: "+self.ipi.to_s
  end

  # PIS ========================================================================
  def calc_pis
    self.pis_base = self.total_value
    self.aliq_pis = self.product.pis
    self.pis      = self.total_value * (self.aliq_pis / 100)
    #logger.info "PIS Base: "+self.pis_base.to_s
    #logger.info "PIS Aliq: "+self.aliq_pis.to_s
    #logger.info "PIS Total: "+self.pis.to_s
  end
  
  # COFINS =====================================================================
  def calc_cofins
    self.cofins_base = self.total_value
    self.aliq_cofins = self.product.cofins
    self.cofins      = self.cofins_base * (self.aliq_cofins / 100)
    #logger.info "COFINS Base: "+self.cofins_base.to_s
    #logger.info "COFINS Aliq: "+self.aliq_cofins.to_s
    #logger.info "COFINS Total: "+self.cofins.to_s
  end
end
