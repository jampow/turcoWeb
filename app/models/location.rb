class Location < ActiveRecord::Base
  has_many :location_items, :dependent => :delete_all
  has_many :receipts, :class_name => "LocationReceipt"
  belongs_to :client
  belongs_to :seller
  belongs_to :payment_form, :foreign_key => "payment_condition_id"
  belongs_to :bank_account

  attr_accessor :client_name
  attr_accessor :seller_name

  validate :presence_of_client
  validate :presence_of_seller
  validates_presence_of :starts_at
  validate :ends_after_start

  def total
    total = 0
    self.location_items.each { |li| total += li.total_value }
    total
  end

  def presence_of_client
    self.errors.add('client_name', 'não pode ficar em branco') if self.client_id.blank? || self.client_name.blank?
  end

  def presence_of_seller
    self.errors.add('seller_name', 'não pode ficar em branco') if self.seller_id.blank? || self.seller_name.blank?
  end

  def ends_after_start
    if !self.starts_at.blank?
      self.errors.add('ends_at', 'deve ser maior que a data de início.') if self.starts_at >= self.ends_at
    end
  end

  accepts_nested_attributes_for :location_items, :reject_if => proc { |a| a[:product_name].blank? }

  def item_grid
    loc = LocationItem.grid self.id
  end

# Select IfNull(       Max(number), 0)          As last
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

  protected

  def mark_item_for_removal
    location_items.each do |child|
      child.mark_for_destruction if child.product_name.blank?
    end
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

end
