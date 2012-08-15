class PaymentForm < ActiveRecord::Base
	has_many :orders

  validates_presence_of :name, :parcels, :p01
  validates_numericality_of :parcels, :greater_than => 0
  validates_numericality_of :p01, :p02, :p03, :p04, :p05, :p06, :p07, :p08, :p09, :p10, :p11, :p12, :allow_nil => true

  def parcels_to_ary
    [self.p01, self.p02, self.p03, self.p04, self.p05, self.p06, self.p07, self.p08, self.p09, self.p10, self.p11, self.p12].compact
  end
end
