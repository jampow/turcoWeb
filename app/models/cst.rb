class Cst < ActiveRecord::Base
  has_many :products
  validates_presence_of :code
  validates_presence_of :description
end

