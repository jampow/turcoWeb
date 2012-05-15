class LocationBill

  attr_accessor :start
  attr_accessor :end

  attr_accessor :discount
  attr_accessor :discount_obs

  attr_accessor :higher
  attr_accessor :higher_obs

  attr_accessor :month_value
  attr_accessor :total_value
  attr_accessor :liquid_value

  def initialize(location_id)
    loc = Location.find(location_id)

    calc_start_and_end(loc)
    calc_value(loc)
  end

  protected

  # Recebe um objeto Location
  def calc_start_and_end(location)
    self.start = Date.today.at_beginning_of_month
    self.end   = Date.today.at_end_of_month

    self.start = location.starts_at if self.start < location.starts_at
    self.end   = location.ends_at   if self.end   > location.ends_at
  end

  # Recebe um objeto Location
  def calc_value(location)
    mon_beg = Date.today.at_beginning_of_month
    mon_end = Date.today.at_end_of_month

    days_month = mon_end  - mon_beg
    days_bill  = self.end - self.start

    self.month_value = location.total

    self.total_value = (BigDecimal.new(days_bill.to_s) * self.month_value) / BigDecimal.new(days_month.to_s)
  end

end