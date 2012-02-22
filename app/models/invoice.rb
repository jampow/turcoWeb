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
  
  validates_presence_of :client_id
  
  named_scope :grid, 
    :select => 'inv.id, cli.name, inv.operation',
    :joins  => 'inv Join clients cli On cli.id = inv.client_id', 
    :order  => "name"
    
  before_save :calc_tax
    
  def calc_tax
    manaus_discount = 0
    products_value  = 0
    invoice_value   = 0
    ipi             = 0
    icms            = 0
    icms_base       = 0
    pis             = 0
    cofins          = 0
    
    itens.each do |i|
      i.ipi = 0
      if i.aliq_ipi > 0
        i.ipi = i.total_value * (i.aliq_ipi / 100)
      end
      
      case sell_type
        when 1 #para venda
          i.icm_base =  i.total_value
          i.icm_base += i.ipi if client.activiy.name.downcase != "indústria"
          i.aliq_icm =  client.billing_address.estate.aliq_icm
          i.icm      =  i.icm_base + (i.aliq_icm / 100)
        when 2 #para beneficiamento
          if client.estate.acronym == 'SP'
            i.icm_base = 0
            i.aliq_icm = 0
            i.icm      = 0
          else
            i.icm_base = i.total_value
            i.aliq_icm = client.billing_address.estate.aliq_icm
            i.icm      = i.icm_base + (i.aliq_icm / 100)
            i.ipi_base = 0
            i.aliq_ipi = 0
            i.ipi      = 0
          end
        when 3 #para simples remessa
          i.icm_base = 0
          i.aliq_icm = 0
          i.icm      = 0
          i.ipi_base = 0
          i.aliq_ipi = 0
          i.ipi      = 0
        when 4 #para aparas
          i.ipi_base = 0
          i.aliq_ipi = 0
          i.ipi      = 0
          i.icm_base = 0
          i.aliq_icm = 0
          i.icm      = 0
          if client.estate.acronym != 'SP'
            i.icm_base = i.total_value
            i.aliq_icm = client.billing_address.estate.aliq_icm
            i.icm      = i.icm_base + (i.aliq_icm / 100)
          end
        when 5 #para venda em manaus
          i.ipi_base    = 0
          i.aliq_ipi    = 0
          i.ipi         = 0
          i.icm_base    = 0
          i.aliq_icm    = 0
          i.icm         = 0
          i.desc_manaus = i.total_value * (i.total_value * 0.93) # 7% de desconto
        when 6 #para beneficiamento com ICMS
          i.ipi_base = 0
          i.aliq_ipi = 0
          i.ipi      = 0
          i.icm_base = i.total_value
          i.aliq_icm = client.billing_address.estate.aliq_icm
          i.icm      = i.icm_base + (i.aliq_icm / 100)
      end
      
      #PIS
      i.pis_base = total_value
      i.aliq_pis = i.product.pis
      i.pis      = i.pis_base * (i.aliq_pis / 100)
      
      #COFINS
      i.cofins_base = total_value
      i.aliq_cofins = i.product.cofins
      i.cofins      = i.cofins_base * (i.aliq_cofins / 100)
      
      #Adiciona totais
      manaus_discount += i.desc_manaus
      products_value  += i.total_value
      invoice_value   += i.total_value + i.ipi
      ipi             += i.ipi
      icms            += i.icm
      icms_base       += i.icm_base
      pis             += i.pis
      cofins          += i.cofins
    end
  end
  
end

