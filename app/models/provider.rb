class Provider < ActiveRecord::Base
  has_many   :attachments                               , :foreign_key => 'external_id', :dependent => :destroy
  has_many   :invoices
  has_many   :receivables     , :through => :invoices

  belongs_to :address                                                                  , :dependent => :destroy
  belongs_to :seller_contact  , :class_name => 'Contact', :foreign_key => 'seller_id'  , :dependent => :destroy
  belongs_to :invoicer_contact, :class_name => 'Contact', :foreign_key => 'invoicer_id', :dependent => :destroy

  accepts_nested_attributes_for :seller_contact  , :reject_if => proc { |a| a[:name].blank? }
  accepts_nested_attributes_for :invoicer_contact, :reject_if => proc { |a| a[:name].blank? }
  accepts_nested_attributes_for :address

  validates_presence_of :code
  validates_presence_of :name
  validates_presence_of :cnpj

  class ProdCost <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 'P', :name => 'Produto'},
      {:id => 'D', :name => 'Despesa'}
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

end

