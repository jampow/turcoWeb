class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :measure_unit
  belongs_to :total_measure_unit       , :class_name => "MeasureUnit"
  belongs_to :total_before_measure_unit, :class_name => "MeasureUnit"
  
  attr_accessor :total_before_to_show
  attr_accessor :total_to_show

  named_scope :product, lambda { |product_id| 
    {:select => "*, IFNULL(quantity_in, - quantity_out) quantity",
     :conditions => ["product_id = ?", product_id]}
  }

  named_scope :last_movimentation, lambda { |product_id|
    {:conditions => ["product_id = ?", product_id], 
     :order => "created_at Desc",
     :limit => 1 }
  }
end
