class LocationReceipt < ActiveRecord::Base
  belongs_to :location
  has_many :items, :class_name => "LocationReceiptItem"

  validate :cross_dates?

  usar_como_dinheiro :discount
  usar_como_dinheiro :higher
  usar_como_dinheiro :month_value
  usar_como_dinheiro :total_value
  usar_como_dinheiro :liquid_value

  before_create :create_receivable
  before_create :normalize_data

  accepts_nested_attributes_for :items

  def calculateFields(location_id)
    self.location_id = location_id
    loc = Location.find(self.location_id)

    calc_start_and_end(loc)
    calc_value(loc)
  end

# Select *
# From location_receipts
# Where location_id = 9
# And ((`start` <= '2012-05-11'
# And   `end`   >= '2012-05-11')
# Or   (`start` <= '2012-06-18'
# And   `end`   >= '2012-06-18'));

  named_scope :between, lambda { |loc_id, starts, ends| {
    :conditions => ["location_id = ? And ((`start` <= ? And `end` >= ?) Or (`start` <= ? And `end` >= ?))", loc_id, starts, starts, ends, ends]
  } }

  def cross_dates?
    loc = LocationReceipt.between self.location_id, self.start, self.end
    self.errors.add_to_base("Este período já possui cobrança") unless loc.blank?
  end

  protected

  def normalize_data
    loc = self.location
    cli = loc.client
    ent = Enterprise.first
    ban = loc.bank_account

    self.location_number    = loc.number
    self.enterp_name        = ent.name
    self.enterp_doc         = ent.cnpj
    self.enterp_ie          = ent.ie
    # self.enterp_im          = ent.im
    self.enterp_address     = ent.address.to_s
    self.client_name        = cli.name
    self.client_doc         = cli.doc
    self.client_ie          = cli.ie
    self.client_im          = cli.im
    self.client_address     = cli.billing_address.to_s
    self.location_starts_at = loc.starts_at
    self.location_ends_at   = loc.ends_at
    self.period             = Date.today.to_formatted_s :period
    self.location_obs       = loc.observation
    self.bank_name          = ban.bank_name
    self.bank_ag            = ban.agency_number
    self.bank_cc            = ban.account_number

    loc.location_items.each do |i|
      rec_i = self.items.build

      rec_i.product     = i.product.name
      rec_i.quantity    = i.quantity

      days_bill  = self.end - self.start

      if days_bill < self.end.day
        rec_i.total_value = (BigDecimal.new(days_bill.to_s) * i.total_value) / BigDecimal.new(30.to_s)
        rec_i.unit_value  = rec_i.total_value / rec_i.quantity
      else
        rec_i.unit_value  = i.unit_value
        rec_i.total_value = i.total_value
      end
    end
  end

  # Recebe um objeto Location
  def calc_start_and_end(location)
    self.start = Date.today.at_beginning_of_month
    self.end   = Date.today.at_end_of_month

    self.start = location.starts_at if self.start < location.starts_at
    # self.end   = location.ends_at   if self.end   > location.ends_at
  end

  # Recebe um objeto Location
  def calc_value(location)
    days_bill  = self.end - self.start

    self.month_value = location.total

    if days_bill < self.end.day
      self.total_value = (BigDecimal.new(days_bill.to_s) * self.month_value) / BigDecimal.new(30.to_s)
    else
      self.total_value = self.month_value
    end
  end

  def create_receivable
    rec = Receivable.create({
      :client_id                => self.location.client_id,
      #:document_number          => self.number,
      :due_date                 => Time.new + 15.days,
      :issue_date               => Time.new,
      :value                    => self.total_value,
      :document_kind_id         => 1,
      :payment_method_id        => 1,
      :frequency_id             => 1,
      :rate_type_id             => 1,
      :rate_calculation_type_id => 1
    })

  end

end
