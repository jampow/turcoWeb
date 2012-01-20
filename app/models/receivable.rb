class Receivable < ActiveRecord::Base
  class DocumentKind <
    Struct.new(:id, :kind)
    VALUES = [
      {:id => 1, :kind => 'Boleto'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:kind]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:kind], v[:id]] }
    end
  end
  class PaymentMethod <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Dinheiro'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end
  end
  class Frequency <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Diariamente'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end
  end

  class RateType <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Manualmente'},
      {:id => 2, :name => 'Automaticamente'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end
  end

  class RateCalculationType <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Diariamente'},
      {:id => 2, :name => 'Mensalmente'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end
  end

  belongs_to :invoice, :primary_key => "invoice_number", :foreign_key => "invoice_number"
  has_many :receivable_cost_divisions

  accepts_nested_attributes_for :receivable_cost_divisions, :allow_destroy => true, :reject_if => proc { |attributes| attributes['value'].blank? }
end

