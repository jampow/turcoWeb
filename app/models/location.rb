class Location < ActiveRecord::Base
  has_many :location_items, :dependent => :delete_all
  has_many :receivables
  belongs_to :client
  belongs_to :seller
  belongs_to :payment_form, :foreign_key => "payment_condition_id"
  belongs_to :bank_account

  attr_accessor :client_name
  attr_accessor :seller_name

  validate :presence_of_client
  validate :presence_of_seller
  validates_presence_of :bank_account_id
  validates_presence_of :starts_at
  #validates_presence_of :ends_at
  validate :ends_after_start
  validate :presence_of_items

  def total
    total = 0
    self.location_items.each { |li| total += li.total_value }
    total
  end

  def presence_of_items
    self.errors.add_to_base('Precisa ter pelo menos um item') if self.location_items.blank?
  end

  def presence_of_client
    self.errors.add('client_name', 'não pode ficar em branco') if self.client_id.blank? || self.client_name.blank?
  end

  def presence_of_seller
    self.errors.add('seller_name', 'não pode ficar em branco') if self.seller_id.blank? || self.seller_name.blank?
  end

  def ends_after_start
    if !self.starts_at.blank? && !self.ends_at.blank?
      self.errors.add('ends_at', 'deve ser maior que a data de início.') if self.starts_at >= self.ends_at
    end
  end

  def m2_total
    sum = 0
    location_items.each do |item|
      sum += item.m2
    end
    sum.to_s
  end

  def items_to_s
    s = ""
    location_items.each do |i|
      s += ", #{i.product.code}"
    end

    s[2...s.length].gsub(/(, )([^,]+?)$/, ' e \2')
  end

  accepts_nested_attributes_for :location_items, :reject_if => proc { |a| a[:product_name].blank? }

  def item_grid
    loc = LocationItem.grid self.id
  end

  def create_receivable(due_date)
    if due_date.nil?
      tod = Date.today
      tod = tod.next_month if tod.day >= 5
      due_date = "#{tod.year}-#{tod.month}-5"
    end

    rec = Receivable.create({
      :client_id                => self.client_id,
      #:document_number          => self.number,
      :due_date                 => Date.parse(due_date),
      :issue_date               => Date.parse(due_date).beginning_of_month.to_time,
      :value                    => self.total,
      :document_kind_id         => 1,
      :payment_method_id        => 1,
      :frequency_id             => 1,
      :rate_type_id             => 1,
      :rate_calculation_type_id => 1,
      :location_id              => self.id,
      :account_id               => BankAccount.first.id
    })

  end

# Select        IfNull(Max(number), 0)          As last
#      , Concat(IfNull(Max(number), 0)+1, "-A") As next
# From locations

  def self.number
    self.find(:first, :select => "IfNull(Max(number), 0) As last, Concat(IfNull(Max(number), 0)+1, '-A') As next")
  end

  before_save :get_next_number
  before_save :mark_item_for_removal

  def get_next_number
    self.number ||= Location.number.next
  end

# Select loc.id
#      , loc.number
#      , cli.name As cli
#      , loc.starts_at
#      , loc.ends_at
# From locations loc
# Left Join clients   cli On cli.id = loc.client_id

  named_scope :grid, :select => "loc.id, loc.number, cli.name As cli, loc.starts_at, loc.ends_at",
                     :joins => "loc Left Join clients cli On cli.id = loc.client_id"

# Select *
# From locations
# Where ends_at Is Null
# Or ends_at > Cast(Now() As Date)

  named_scope :actives, :conditions => "ends_at Is Null Or ends_at > Cast(Now() As Date)"

# Select Count(pro.id) As qtd
#      , Sum(pro.width * pro.depth) As met2
#      , Sum(pro.width * pro.depth * pro.height) As met3
# From locations lo
# Join location_items li On li.location_id = lo.id
# Join products pro On pro.id = li.product_id
# Where lo.ends_at Is Null
# Or lo.ends_at > Cast(Now() As Date);

  named_scope :report_located, :select => "Count(pro.id) As qtd, Sum(pro.width*pro.depth) As met2, Sum(pro.width*pro.depth*pro.height) As met3",
                               :joins  => "lo Join location_items li On li.location_id = lo.id Join products pro On pro.id = li.product_id",
                               :conditions => "lo.ends_at Is Null Or lo.ends_at > Cast(Now() As Date)"

  protected

  def mark_item_for_removal
    location_items.each do |child|
      child.mark_for_destruction if child.product_name.blank?
    end
  end

end
