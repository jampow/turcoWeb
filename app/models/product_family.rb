class ProductFamily < ActiveRecord::Base
  has_many :products, :foreign_key => "family_id"
end

