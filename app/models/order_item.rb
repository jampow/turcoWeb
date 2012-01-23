class OrderItem < ActiveRecord::Base
  attr_accessor :product_name
  attr_accessor :measure_unit
  belongs_to :order
  
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
end

