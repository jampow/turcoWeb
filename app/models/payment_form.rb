class PaymentForm < ActiveRecord::Base
	has_many :orders

  def parcels
    [self.p01, self.p02, self.p03, self.p04, self.p05, self.p06, self.p07, self.p08, self.p09, self.p10, self.p11, self.p12].compact
  end
end
