class Payable < ActiveRecord::Base
  validates_presence_of :provider_id
  validates_presence_of :issue_date
  validates_presence_of :due_date
  validates_presence_of :value
  validate :due_greater_than_issue_date

  def due_greater_than_issue_date
    unless due_date.nil? || issue_date.nil?
      self.errors.add("due_date", " tem que ser posterior ou igual a data de emissão") if due_date < issue_date.to_date
    end
  end

  belongs_to :invoice, :primary_key => "invoice_number", :foreign_key => "invoice_number"
  belongs_to :provider
  belongs_to :bank_account, :foreign_key => "account_id"

  has_many :payable_cost_divisions
  has_many :billings, :class_name => 'PayableBilling'

  accepts_nested_attributes_for :payable_cost_divisions, :allow_destroy => true, :reject_if => proc { |attributes| attributes['value'].blank? }

  attr_accessor :provider_name

  # def after_initialize
  #   self.provider_name = Provider.find(self.provider_id, :select => 'name').name if self.provider_id
  # end

# Select pay.id
#      , pro.name as provider
#      , pay.invoice_number
#      , pay.due_date
#      , pay.value
#      , pay.settled
# From payables  pay
# Join providers pro On pro.id = pay.provider_id

  named_scope :grid, :select => "pay.id, pro.name as pro, pay.invoice_number, pay.due_date, pay.value, pay.settled",
                     :joins  => "pay Join providers pro On pro.id = pay.provider_id"

  named_scope :monthly, :conditions => "frequency_id = 2"

  def reached_limit?
    total_from_billings >= value ? true : false
  end

  def total_from_billings
    sum = 0
    billings.each do |bill|
      sum += bill.total
    end
    sum
  end

  def duplicate
    p = Payable.new(attributes)
    p.parcel = parcel ? parcel + 1 : 1
    p.due_date = p.due_date + 1.month
    p.save!
  end

  class DocumentKind <
    Struct.new(:id, :kind)
    VALUES = [
      {:id => 1, :kind => 'Boleto'},
      {:id => 2, :kind => 'Recibo'},
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:kind]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:kind], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:kind])
    end
  end
  class PaymentMethod <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Dinheiro'},
      {:id => 2, :name => 'Cheque'},
      {:id => 3, :name => 'Boleto'},
      {:id => 4, :name => 'Depósito'},
      {:id => 5, :name => 'Crédito'},
      {:id => 6, :name => 'Débito'}
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
  class Frequency <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Única'},
      {:id => 2, :name => 'Mensal'}
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

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
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

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end

end

