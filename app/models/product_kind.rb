class ProductKind < ActiveRecord::Base
  has_many :products, :foreign_key => "type_id"
end

