class Product < ActiveRecord::Base
  belongs_to :product_kind  , :foreign_key => "type_id"
  belongs_to :product_family, :foreign_key => "family_id"
  belongs_to :cst_cofins
  belongs_to :cst_icm
  belongs_to :cst_ipi
  belongs_to :cst_pis
  has_many   :attachments, :foreign_key => 'external_id', :dependent => :destroy
  has_many   :measure_units
  
  #named_scope :quantity, :select => "sum()" :conditions => { :field => condition }, :order => "field"
  
  def quantity
    Stock.last :conditions => ["product_id = ?", self.id]
  end
end


