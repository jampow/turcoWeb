class Product < ActiveRecord::Base
  belongs_to :product_kind  , :foreign_key => "type_id"
  belongs_to :product_family, :foreign_key => "family_id"
  belongs_to :cst_cofins
  belongs_to :cst_icm
  belongs_to :cst_ipi
  belongs_to :cst_pis
  has_many   :attachments, :foreign_key => 'external_id', :dependent => :destroy
end

