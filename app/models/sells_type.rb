class SellsType < ActiveRecord::Base
  has_many :invoices
  validates_presence_of :name

  class Type <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Venda'},
      {:id => 2, :name => 'Compra'},
      {:id => 3, :name => 'Simples remessa'},
      {:id => 4, :name => 'Aparas'},
      {:id => 5, :name => 'Venda em Manaus'},
      {:id => 6, :name => 'Beneficiamento com ICMS'}
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
