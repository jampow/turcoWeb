class LocationReceipt < ActiveRecord::Base
  belongs_to :location
  validate :cross_dates?

  before_create :create_receivable

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

  #TODO: Passar esse método pro model Invoice, quando já estiver funcionando o envio
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
