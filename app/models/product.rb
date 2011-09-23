class Product < ActiveRecord::Base
  belongs_to :product_kind, :foreign_key => "type_id"
end

