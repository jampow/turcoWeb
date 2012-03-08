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

  named_scope :number, :select => "max(invoice_number) As last, max(invoice_number)+1 As next"
  named_scope :grid,
    :select => 'inv.id, cli.name, inv.operation',
    :joins  => 'inv Join clients cli On cli.id = inv.client_id',
    :order  => "name"

  before_save :mark_item_for_removal
  before_save :calc_tax

  def calc_tax
    self.manaus_discount = 0
    self.products_value  = 0
    self.invoice_value   = 0
    self.ipi             = 0
    self.icms            = 0
    self.icms_base       = 0
    self.pis             = 0
    self.cofins          = 0

    itens.each do |i|
      i.calc_ipi

      case sell_id
        when 1 #para venda
          #logger.info "case 1"
          i.calc_icms true, client.activity.name, client.aliq_icms
        when 2 #para beneficiamento
          if client.billing_estate.acronym == 'SP'
            #logger.info "case 2 if"
            i.zero_icms
          else
            #logger.info "case 2 else"
            i.calc_icms false, client.activity.name, client.aliq_icms
            i.zero_ipi
          end
        when 3 #para simples remessa
          #logger.info "case 3"
          i.zero_icms
          i.zero_ipi
        when 4 #para aparas
          #logger.info "case 4"
          i.zero_icms
          i.zero_ipi
          if client.billing_estate.acronym != 'SP'
            #logger.info "case 4 if"
            i.calc_icms false, client.activity.name, client.aliq_icms
          end
        when 5 #para venda em manaus
          #logger.info "case 5"
          i.zero_icms
          i.zero_ipi
          i.desc_manaus = i.total_value * 0.07
        when 6 #para beneficiamento com ICMS
          #logger.info "case 6"
          i.calc_icms false, client.activity.name, client.aliq_icms
          i.zero_ipi
      end

      i.calc_pis
      i.calc_cofins

      #Adiciona totais
      self.manaus_discount += i.desc_manaus
      self.products_value  += i.total_value
      self.invoice_value   += i.total_value + i.ipi
      self.ipi             += i.ipi
      self.icms            += i.icm
      self.icms_base       += i.icm_base
      self.pis             += i.pis
      self.cofins          += i.cofins
    end
  end

  class FreightType <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 0, :name => 'Por conta do emitente'},
      {:id => 1, :name => 'Por conta do destinatário'},
      {:id => 2, :name => 'Por conta de terceiros'},
      {:id => 9, :name => 'Sem frete'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end

protected

  def mark_item_for_removal
    itens.each do |child|
      child.mark_for_destruction if child.product_name.blank?
    end
  end

end

