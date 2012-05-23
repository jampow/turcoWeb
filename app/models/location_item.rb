class LocationItem < ActiveRecord::Base
  belongs_to :location
  belongs_to :product
  belongs_to :measure_unit

  attr_accessor :product_name

# Select loc.*
#      , pro.name
#      , mun.measure_unit
# From location_items loc
# Join products pro On pro.id = loc.product_id
# Left Join measure_units mun On mun.id = loc.measure_unit_id
# Where loc.location_id = 1

  named_scope :grid, lambda { |location_id|
    {:select => "loc.*, pro.name As prod_name, mun.measure_unit As unit",
     :joins => "loc Join products pro On pro.id = loc.product_id Left Join measure_units mun On mun.id = loc.measure_unit_id",
     :conditions => ["loc.location_id = ?", location_id],
     :order => "loc.id"}}

end
