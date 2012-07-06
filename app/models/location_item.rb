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

# Select lo.number
#      , lo.starts_at
#      , pr.code
#      , pr.name
#      , li.total_value
# From location_items li
# Join products       pr On pr.id = li.product_id
# Join locations      lo On lo.id = li.location_id
# Join clients        cl On cl.id = lo.client_id
# Where cl.id = 1;

  named_scope :from_client, lambda { |client_id| {
    :select => "lo.number, lo.starts_at, pr.code, pr.name, li.total_value",
    :joins  => "li Join products pr On pr.id = li.product_id Join locations lo On lo.id = li.location_id Join clients cl On cl.id = lo.client_id",
    :conditions => ["cl.id = ?", client_id]
  }}

  def m2
    product.m2
  end

end
