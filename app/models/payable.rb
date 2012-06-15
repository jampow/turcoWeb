class Payable < ActiveRecord::Base
  validates_presence_of :client_id
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
  belongs_to :client
  belongs_to :bank_account, :foreign_key => "account_id"

  has_many :payable_cost_divisions
  has_many :billings, :class_name => 'PayableBilling'

  accepts_nested_attributes_for :payable_cost_divisions, :allow_destroy => true, :reject_if => proc { |attributes| attributes['value'].blank? }

  attr_accessor :client_name

  # def after_initialize
  #   self.client_name = Client.find(self.client_id, :select => 'name').name if self.client_id
  # end

# Select pay.id
#      , cli.name as client
#      , pay.invoice_number
#      , pay.due_date
#      , pay.value
#      , pay.settled
# From payables pay
# Join clients     cli On cli.id = pay.client_id

  named_scope :grid, :select => "pay.id, cli.name as cli, pay.invoice_number, pay.due_date, pay.value, pay.settled",
                     :joins  => "pay Join clients cli On cli.id = pay.client_id"

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

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:kind])
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

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
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
