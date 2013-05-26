class Receivable < ActiveRecord::Base
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
  belongs_to :location

  has_many :receivable_cost_divisions
  has_many :billings, :class_name => 'ReceivableBilling'

  accepts_nested_attributes_for :receivable_cost_divisions, :allow_destroy => true, :reject_if => proc { |attributes| attributes['value'].blank? }
  before_save :mark_item_for_removal
  before_save :set_default_account_plan

  attr_accessor :client_name

  # def after_initialize
  #   self.client_name = Client.find(self.client_id, :select => 'name').name if self.client_id
  # end

# Select rec.id
#      , cli.name as client
#      , rec.invoice_number
#      , rec.due_date
#      , rec.value
#      , rec.settled
# From receivables rec
# Join clients     cli On cli.id = rec.client_id

  # named_scope :grid, :select => "rec.id, cli.name as cli, rec.invoice_number, rec.due_date, rec.value, rec.settled",
  #                    :joins  => "rec Join clients cli On cli.id = rec.client_id"

  named_scope :grid, lambda { |starts_at, ends_at, field_filter|
                        cond = [""]
                        if field_filter == "1"
                          field = "rec.due_date"
                        else
                          field = "rec.issue_date"
                        end
                        if !starts_at.blank?
                          cond[0] += " And "+field+" >= ?"
                          cond << starts_at
                        end
                        if !ends_at.blank?
                          cond[0] += " And "+field+" <= ?"
                          cond << ends_at
                        end
                        if cond[0].length > 0
                          cond[0] = cond[0][5..cond[0].length]
                        end
                        { :select => "rec.id, cli.name as cli, rec.invoice_number, rec.issue_date, rec.due_date, rec.value, rec.settled",
                          :joins  => "rec Join clients cli On cli.id = rec.client_id",
                          :conditions => cond } }


  named_scope :total_behind_due_date, lambda { |starts_at, ends_at| {
                                      :select => "Sum(value) As total",
                                      :conditions => ["due_date >= ? And due_date <= ?", starts_at, ends_at] } }

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

  def fast_settlement
    ReceivableBilling.create(
      :client_id       => client_id,
      :bank_account_id => bank_id,
      :expire_at       => due_date,
      :received_at     => due_date,
      :value           => value - total_from_billings,
      :total           => value - total_from_billings,
      :receivable_id   => id
    )
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

protected

  def mark_item_for_removal
    receivable_cost_divisions.each do |child|
      child.mark_for_destruction if (child.account_plan_id.blank? && child.cost_center_id.blank?) || child.value.blank?
    end
  end

  def set_default_account_plan
    counter = 0

    receivable_cost_divisions.each do |child|
      counter = counter + 1 if (!child.account_plan_id.blank? && !child.cost_center_id.blank?) && !child.value.blank?
    end

    if counter == 0
      acplan_default = AccountPlan.find_by_orientation_id_and_default(1, true)
      cocenter_default = acplan_default.cost_centers

      cocenter_default.each do |division|
        apport = Apportionment.find_by_account_plan_id_and_cost_center_id(acplan_default.id, division.id)
        rec_cost_div_def = ReceivableCostDivision.new(
         :account_plan_id => acplan_default.id,
         :cost_center_id => apport.id,
         :value => self.value * ( apport.rate / 100 ) )

        self.receivable_cost_divisions << rec_cost_div_def
      end
    end
  end

end

