class OrderItem < ActiveRecord::Base
  attr_accessor :product_name
  attr_accessor :measure_unit
  belongs_to :order
  belongs_to :product

  validates_numericality_of :unit_value, :quantity, :greater_than => 0

  before_save :calculate_total

  def after_initialize
    self.product_name = Product.find(self.product_id).name if self.product_id
    self.measure_unit = MeasureUnit.find(self.measure_unit_id).measure_unit if self.measure_unit_id
  end

# Select oi.*
#      , pr.name
#      , mu.measure_unit
# From order_items   oi Join
#      products      pr On pr.id = oi.product_id Join
#      measure_units mu On mu.id = oi.measure_unit_id
# Where oi.id = 1

  named_scope :grid, lambda { |order_id|
    {:select => "oi.*, pr.name as product_name, mu.measure_unit",
     :joins => "oi Join products pr On pr.id = oi.product_id Join measure_units mu On mu.id = oi.measure_unit_id",
     :conditions => ["oi.order_id = ?", order_id],
     :order => "id"}
  }

  protected

  def calculate_total
    self.total_value = unit_value * quantity
  end
end

